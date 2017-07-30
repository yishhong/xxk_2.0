//
//  VPForgetController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPForgetController.h"
#import "UIBarButtonItem+Custom.h"
#import "UINavigationBar+Custom.h"
#import "VPAuthCodeController.h"
#import "VPLoginViewModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"

@interface VPForgetController ()

@property(strong, nonatomic)VPLoginViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation VPForgetController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel =[[VPLoginViewModel alloc]init];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBack)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightNext)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = @"找回密码";
    
    [self.navigationItem.leftBarButtonItem xx_barButtonTitleFont];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    [self.navigationController.navigationBar xx_titleStyle];
    
}

- (void)leftBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNext{
    
    [MBProgressHUD showLoading];
    [self.viewModel postShortMessage:self.phoneText.text type:VPShortMessageType_ModifyPassWord success:^{
        [MBProgressHUD hide];
        VPAuthCodeController * authCodeController =[VPAuthCodeController instantiation];
        authCodeController.telephone =self.phoneText.text;
        authCodeController.codeType =VPAuthCodeType_ModifyPassWord;
        [self.navigationController pushViewController:authCodeController animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
