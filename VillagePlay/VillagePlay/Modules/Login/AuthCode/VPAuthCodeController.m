//
//  VPAuthCodeController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAuthCodeController.h"
#import "UINavigationBar+Custom.h"
#import "UIBarButtonItem+Custom.h"
#import "UIButton+CountDown.h"
#import "VPLoginViewModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UIColor+HUE.h"
#import "UIButton+TouchAreaInsets.h"
#import "VPAgreementController.h"


@interface VPAuthCodeController ()
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UITextField *codeTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) VPLoginViewModel * viewModel;

@property (strong, nonatomic) IBOutlet UIButton *accordButton;

@property (strong, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation VPAuthCodeController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel =[[VPLoginViewModel alloc]init];
    self.phoneLabel.text =[NSString stringWithFormat:@"您的手机%@",self.telephone];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBack)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightSubmit)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = @"手机号注册";
    
    [self.navigationItem.leftBarButtonItem xx_barButtonTitleFont];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    [self.navigationController.navigationBar xx_titleStyle];
    
    [self.sendButton startTime:59 title:@"点击重新获取验证码" waitTittle:@"秒重新获取验证码"];
    
    self.selectButton.selected=NO;
    [self.selectButton setTouchAreaInsets:UIEdgeInsetsMake(30, 12, 30, 10)];
    
    if (self.codeType==VPAuthCodeType_ModifyPassWord) {
        
        self.accordButton.hidden =YES;
        self.accordButton.userInteractionEnabled =NO;
        self.selectButton.hidden =YES;
        self.selectButton.userInteractionEnabled =NO;
        self.passwordTextField.placeholder=@"设置您的新密码";

    }else{
    
        self.accordButton.hidden =NO;
        self.accordButton.userInteractionEnabled =YES;
        self.selectButton.hidden =NO;
        self.selectButton.userInteractionEnabled =YES;
        self.passwordTextField.placeholder=@"设置您的登录密码";

    }
}

- (void)leftBack{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  查看协议
 *
 *  @param sender <#sender description#>
 */
- (IBAction)accordAction:(UIButton *)sender {

    [self.navigationController pushViewController:[VPAgreementController instantiation] animated:YES];
}
- (IBAction)selectAction:(UIButton *)sender {
    
    if (sender.selected==NO) {
        [self.selectButton setImage:[UIImage imageNamed:@"vp_verification"] forState:UIControlStateNormal];
        sender.selected=YES;

    }else{
        
        [self.selectButton setImage:[UIImage imageNamed:@"vp_verification_select"] forState:UIControlStateNormal];
        sender.selected=NO;

    }
}

- (void)rightSubmit{
    if (self.codeType==VPAuthCodeType_Register) {
        if (self.selectButton.selected==YES) {
            [MBProgressHUD showTip:@"协议未选择"];
            return;
        }
        [MBProgressHUD showLoading];
        [self.viewModel registUserPhoneNum:self.telephone location:@"28.11,112.58" verification:self.codeTextField.text pwd:self.passwordTextField.text success:^{
            [MBProgressHUD hide];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
        
    }else{
            [MBProgressHUD showLoading];
            [self.viewModel modifyPassWord:self.telephone pwd:self.passwordTextField.text rePwd:self.passwordTextField.text  verification:self.codeTextField.text success:^{
                [MBProgressHUD showTip:@"修改成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
}

- (IBAction)sendCodeAction:(id)sender {
    
    [MBProgressHUD showLoading];
    [self.viewModel postShortMessage:self.telephone type:VPShortMessageType_Register success:^{
        [MBProgressHUD hide];
        [self.sendButton startTime:59 title:@"点击重新获取验证码" waitTittle:@"秒重新获取验证码"];
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
