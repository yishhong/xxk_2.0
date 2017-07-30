//
//  VPHotelOrderOptionController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderOptionController.h"
#import "VPHotelOrderOptionViewModel.h"
#import "UIColor+HUE.h"
#import "CAPSPageMenu.h"
#import "VPHotelOrderController.h"

@interface VPHotelOrderOptionController ()<CAPSPageMenuDelegate>

@property (nonatomic, strong) VPHotelOrderOptionViewModel *viewModel;
@property(strong,nonatomic) CAPSPageMenu * pageMenu;


@end

@implementation VPHotelOrderOptionController

+ (instancetype)instantiation{
    VPHotelOrderOptionController * vc = [[VPHotelOrderOptionController alloc] init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPHotelOrderOptionViewModel alloc] init];
    self.title = @"民宿订单";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
    VPHotelOrderController *all = [VPHotelOrderController instantiation];
    all.title = @"全部";
    all.orderType=@"0";
    VPHotelOrderController *pending = [VPHotelOrderController instantiation];
    pending.title = @"待确认";
    pending.orderType =@"1";
    VPHotelOrderController *waitCheckIn = [VPHotelOrderController instantiation];
    waitCheckIn.title = @"等待入住";
    waitCheckIn.orderType =@"2";
    VPHotelOrderController *finish = [VPHotelOrderController instantiation];
    finish.title = @"已完成";
    finish.orderType =@"3";
    VPHotelOrderController *refund = [VPHotelOrderController instantiation];
    refund.title = @"退款单";
    refund.orderType =@"4";

    
    
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
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:@[all,pending,waitCheckIn,finish,refund] frame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) options:parameters];
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
