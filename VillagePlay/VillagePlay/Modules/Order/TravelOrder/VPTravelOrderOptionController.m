//
//  VPTravelOrderOptionController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderOptionController.h"
#import "VPTravelOrderOptionViewModel.h"
#import "UIColor+HUE.h"
#import "CAPSPageMenu.h"
#import "VPTravelOrderController.h"

@interface VPTravelOrderOptionController ()<CAPSPageMenuDelegate>

@property (nonatomic, strong) VPTravelOrderOptionViewModel *viewModel;
@property(strong,nonatomic) CAPSPageMenu * pageMenu;


@end

@implementation VPTravelOrderOptionController

+ (instancetype)instantiation{
    VPTravelOrderOptionController * vc = [[VPTravelOrderOptionController alloc] init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //0待付款,4已完成,2已取消,3已退款,1待出行
    self.viewModel = [[VPTravelOrderOptionViewModel alloc] init];
    self.title = @"旅游订单";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
    VPTravelOrderController *waitPayment = [VPTravelOrderController instantiation];
    waitPayment.title = @"待付款";
    waitPayment.orderState =@"0";
    VPTravelOrderController *waitTravel = [VPTravelOrderController instantiation];
    waitTravel.title = @"待出行";
    waitTravel.orderState =@"1";
    VPTravelOrderController *finish = [VPTravelOrderController instantiation];
    finish.title = @"已完成";
    finish.orderState =@"4";
    VPTravelOrderController *cancel = [VPTravelOrderController instantiation];
    cancel.title = @"已取消";
    cancel.orderState=@"2";
    VPTravelOrderController *refund = [VPTravelOrderController instantiation];
    refund.title = @"退款单";
    refund.orderState =@"3";

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
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:@[waitPayment,waitTravel,finish,cancel,refund] frame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) options:parameters];
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
