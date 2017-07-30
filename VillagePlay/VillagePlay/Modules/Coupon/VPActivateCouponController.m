//
//  VPActivateCouponController.mController
//  VillagePlay
//
//  Created by Apricot on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPActivateCouponController.h"
#import "VPActivateCouponViewModel.h"
#import "MBProgressHUD+Loading.h"

@interface VPActivateCouponController ()

@property (nonatomic, strong) VPActivateCouponViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITextField *tf_key;
@property (strong, nonatomic) IBOutlet UIButton *activateButton;
@end

@implementation VPActivateCouponController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Coupon" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPActivateCouponViewModel alloc] init];
    
    self.title = @"激活优惠券";
    self.activateButton.layer.cornerRadius = 2;
    [self.activateButton addTarget:self action:@selector(activateCoupon) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 10, 0);
    self.tf_key.leftView = view;
    self.tf_key.rightView = view;
    self.tf_key.leftViewMode = UITextFieldViewModeAlways;
    self.tf_key.rightViewMode = UITextFieldViewModeAlways;
}

- (void)activateCoupon{
    [self.tf_key resignFirstResponder];
    self.viewModel.couponCode = self.tf_key.text;
    [MBProgressHUD showLoading];
    [self.viewModel activateCouponSuccess:^{
        [MBProgressHUD showTip:@"激活成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
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
