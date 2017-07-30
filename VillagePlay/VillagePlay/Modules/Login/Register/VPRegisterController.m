//
//  VPRegisterController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRegisterController.h"
#import "UINavigationBar+Custom.h"
#import "UIBarButtonItem+Custom.h"
#import "VPAuthCodeController.h"
#import "VPLoginViewModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"


@interface VPRegisterController ()

@property(strong, nonatomic)VPLoginViewModel * viewModel;
@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation VPRegisterController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad{
    [super viewDidLoad];
     self.viewModel=[[VPLoginViewModel alloc]init];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBack)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightNext)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = @"手机号注册";
    
    [self.navigationItem.leftBarButtonItem xx_barButtonTitleFont];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    [self.navigationController.navigationBar xx_titleStyle];

}

- (void)leftBack{
    if([self.navigationController.viewControllers count]>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightNext{

        [MBProgressHUD showLoading];
        [self.viewModel postShortMessage:self.phoneText.text type:VPShortMessageType_Register success:^{
            [MBProgressHUD hide];
            VPAuthCodeController * authCodeController =[VPAuthCodeController instantiation];
            authCodeController.telephone =self.phoneText.text;
            authCodeController.codeType =VPAuthCodeType_Register;
            [self.navigationController pushViewController:authCodeController animated:YES];
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showTip:[error errorMessage]];
        }];
}
@end
