//
//  VPTicketOrderOptionController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderOptionController.h"
#import "VPTicketOrderOptionViewModel.h"
#import "UIColor+HUE.h"
#import "CAPSPageMenu.h"
#import "VPTicketOrderController.h"

@interface VPTicketOrderOptionController ()<CAPSPageMenuDelegate>

@property (nonatomic, strong) VPTicketOrderOptionViewModel *viewModel;
@property(strong,nonatomic) CAPSPageMenu * pageMenu;


@end

@implementation VPTicketOrderOptionController

+ (instancetype)instantiation{
    VPTicketOrderOptionController * vc = [[VPTicketOrderOptionController alloc] init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    0 待付款 1 待出行 2 预订取消 3 退款 4已完成 -1全部

    self.viewModel = [[VPTicketOrderOptionViewModel alloc] init];
    self.title = @"门票订单";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
    VPTicketOrderController *all = [VPTicketOrderController instantiation];
    all.title = @"全部";
    all.type =@"-1";
    VPTicketOrderController *waitPayment = [VPTicketOrderController instantiation];
    waitPayment.title = @"待付款";
    waitPayment.type =@"0";
    VPTicketOrderController *waitTravel = [VPTicketOrderController instantiation];
    waitTravel.title = @"待出行";
    waitTravel.type =@"1";
    VPTicketOrderController *finish = [VPTicketOrderController instantiation];
    finish.title = @"已完成";
    finish.type = @"4";
    VPTicketOrderController *refund = [VPTicketOrderController instantiation];
    refund.title = @"退款单";
    refund.type = @"3";

    
    NSDictionary *parameters =@{
                                CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor navigationTintColor],
                                CAPSPageMenuOptionSelectionIndicatorColor: [UIColor navigationTintColor],
                                CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:0.8877 green:0.8876 blue:0.8877 alpha:1.0],
                                CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor blackTextColor],
                                CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:14],
                                CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                CAPSPageMenuOptionSelectionIndicatorHeight:@(1.5),
                                CAPSPageMenuOptionMenuHeight:@44
                                };
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:@[all,waitPayment,waitTravel,finish,refund] frame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) options:parameters];
    self.pageMenu.delegate = self;
    [self.view addSubview:self.pageMenu.view];
    [self addChildViewController:self.pageMenu];

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
