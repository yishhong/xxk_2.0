//
//  VPCollectionController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCollectionController.h"
#import "VPCollectionViewModel.h"
#import "UIColor+HUE.h"
#import "CAPSPageMenu.h"
#import "VPSubCollectionController.h"


@interface VPCollectionController ()<CAPSPageMenuDelegate>

@property (nonatomic, strong) VPCollectionViewModel *viewModel;

@property(strong,nonatomic) CAPSPageMenu * pageMenu;

@end

@implementation VPCollectionController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Collection" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPCollectionViewModel alloc] init];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
    VPSubCollectionController *villageCollection = [VPSubCollectionController instantiation];
    villageCollection.collectionRecordtype = VPChannelTypeVillage;
    villageCollection.title = @"景点";
    
    VPSubCollectionController *travelCollection = [VPSubCollectionController instantiation];
    travelCollection.collectionRecordtype = VPChannelTypeTravel;
    travelCollection.title = @"旅游";

    VPSubCollectionController *hotelCollection = [VPSubCollectionController instantiation];
    hotelCollection.collectionRecordtype = VPChannelTypeHotel;
    hotelCollection.title = @"民宿";
    
    VPSubCollectionController *ticketCollection = [VPSubCollectionController instantiation];
    ticketCollection.collectionRecordtype = VPChannelTypeTicket;
    ticketCollection.title = @"门票";
//由于专题目前使用的WEB页面所以这里暂时屏蔽
//    VPSubCollectionController *topicCollection = [VPSubCollectionController instantiation];
//    topicCollection.collectionRecordtype = VPChannelTypeTopic;
//    topicCollection.title = @"专题";
    
    VPSubCollectionController *playCollection = [VPSubCollectionController instantiation];
    playCollection.collectionRecordtype = VPChannelTypePlay;
    playCollection.title = @"玩法";
    
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
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:@[villageCollection,travelCollection,hotelCollection,ticketCollection,playCollection] frame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) options:parameters];
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
