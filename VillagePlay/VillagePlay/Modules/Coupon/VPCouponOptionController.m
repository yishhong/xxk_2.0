//
//  VPCouponOptionController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponOptionController.h"
#import "VPCouponOptionViewModel.h"
#import "CAPSPageMenu.h"
#import "VPCouponController.h"
#import "UIColor+HUE.h"
#import "UIBarButtonItem+Custom.h"
#import "VPActivateCouponController.h"
#import "CommentDetaileEnum.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"

@interface VPCouponOptionController ()<CAPSPageMenuDelegate>

@property (nonatomic, strong) VPCouponOptionViewModel *viewModel;
@property (nonatomic, strong) CAPSPageMenu * pageMenu;

@end

@implementation VPCouponOptionController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Coupon" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    self.viewModel = [[VPCouponOptionViewModel alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"激活" style:UIBarButtonItemStylePlain target:self action:@selector(activate)];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    
    [MBProgressHUD showLoading];
    [self.viewModel loadCouponCountSuccess:^(NSDictionary *dict) {
        if(!self.pageMenu){
            VPCouponController *unuse = [VPCouponController instantiation];
            unuse.title = [NSString stringWithFormat:@"未使用(%zd)",[dict[@"validityCount"] integerValue]];
            unuse.state = CouponUseStateUnuse;
            VPCouponController *use = [VPCouponController instantiation];
            use.title = [NSString stringWithFormat:@"已使用(%zd)",[dict[@"usedCount"] integerValue]];
            use.state = CouponUseStateUse;
            VPCouponController *overdue = [VPCouponController instantiation];
            overdue.title = [NSString stringWithFormat:@"已过期(%zd)",[dict[@"expiredCount"] integerValue]];
            overdue.state = CouponUseStateOverdue;
            NSDictionary *parameters =@{
                                        CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                        CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor navigationTintColor],
                                        CAPSPageMenuOptionSelectionIndicatorColor: [UIColor navigationTintColor],
                                        CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:0.8877 green:0.8876 blue:0.8877 alpha:1.0],
                                        CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor blackTextColor],
                                        CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:14],
                                        CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                        CAPSPageMenuOptionSelectionIndicatorHeight:@(1),
                                        };
            self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:@[unuse,use,overdue] frame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) options:parameters];
            self.pageMenu.delegate = self;
            [self.view addSubview:self.pageMenu.view];
            [self addChildViewController:self.pageMenu];
        }else{
            MenuItemView *unuseItemView = [self.pageMenu.menuItems objectAtIndex:0];
            unuseItemView.titleLabel.text = [NSString stringWithFormat:@"未使用(%zd)",[dict[@"validityCount"] integerValue]];
            MenuItemView *useItemView = [self.pageMenu.menuItems objectAtIndex:1];
            useItemView.titleLabel.text = [NSString stringWithFormat:@"已使用(%zd)",[dict[@"usedCount"] integerValue]];
            MenuItemView *overdueItemView = [self.pageMenu.menuItems lastObject];
            overdueItemView.titleLabel.text = [NSString stringWithFormat:@"已过期(%zd)",[dict[@"expiredCount"] integerValue]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

- (void)activate{
    [self.navigationController pushViewController:[VPActivateCouponController instantiation] animated:YES];
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
