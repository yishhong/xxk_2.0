//
//  VPLoginController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLoginController.h"
#import "UIBarButtonItem+Custom.h"
#import "UINavigationBar+Custom.h"
#import "UIColor+HUE.h"
#import "VPRegisterController.h"
#import "VPForgetController.h"
#import "VPLoginViewModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import <UMSocialCore/UMSocialCore.h>
#import "VPNavigationController.h"


@interface VPLoginController ()
@property (strong, nonatomic) IBOutlet UIButton *forgetButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *tf_Phone;
@property (strong, nonatomic) IBOutlet UITextField *tf_Password;
@property (strong,nonatomic) VPLoginViewModel *viewModel;
/**
 *  其他登录的View
 */
@property (strong, nonatomic) IBOutlet UIView *otherLoginView;

@end

@implementation VPLoginController


+ (UIViewController *)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    UIViewController *vc =  [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    VPNavigationController *navigation = [[VPNavigationController alloc] initWithRootViewController:vc];
    return navigation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录下乡客";
    self.viewModel =[[VPLoginViewModel alloc]init];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(leftClose)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightRegister)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14] ,NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self.navigationItem.leftBarButtonItem xx_barButtonTitleFont];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyle];
    
    //忘记密码添加事件
    [self.forgetButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftClose{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightRegister{
    
    [self.navigationController pushViewController:[VPRegisterController instantiation] animated:YES];
}

- (void)forgetPassword{
    
    [self.navigationController pushViewController:[VPForgetController instantiation] animated:YES];
}

#pragma mark -Action respond

- (void)login{
    
    [MBProgressHUD showLoading];
    [self.viewModel loginUserName:self.tf_Phone.text pwd:self.tf_Password.text location:@"" success:^{
        [MBProgressHUD hide];
        [self leftClose];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (IBAction)loginWithWechat:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if(error){
            [MBProgressHUD showTip:@"登录失败"];
        }else{
            [MBProgressHUD showLoading];
            UMSocialUserInfoResponse *userInfoResponse = result;
            [self.viewModel wechatLoginWithParams:userInfoResponse success:^{
                [MBProgressHUD hide];
                [self leftClose];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
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
