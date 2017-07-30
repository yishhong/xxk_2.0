//
//  VPTravelMainController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelMainController.h"
#import "VPTravelMainViewModel.h"
#import "VPTravelController.h"
#import "UIColor+HUE.h"
#import "CAPSPageMenu.h"
#import "TravelUpSlideView.h"
#import "UIColor+HUE.h"
#import "VPTravelTagsModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPLocationAndSearchView.h"
#import "VPSubSearchView.h"
#import "MBProgressHUD+Loading.h"
#import "VPLocationManager.h"
#import "NSError+Reason.h"
#import "VPCityListController.h"
#import "VPSearchController.h"
#import "UIViewController+Empty.h"

@interface VPTravelMainController ()<CAPSPageMenuDelegate,TravelUpSlideViewDelegate>

@property (nonatomic, strong) VPTravelMainViewModel *viewModel;

@property(strong,nonatomic) CAPSPageMenu * pageMenu;

@property(strong, nonatomic)TravelUpSlideView *traveUpSlideView;

@property (strong, nonatomic) NSMutableArray * dateSource;

@property (strong, nonatomic) VPLocationAndSearchView *locationAndSearchView;

@property (strong, nonatomic) VPSubSearchView *subSearchView;

@property (strong, nonatomic) VPOpenCityInfoModel *cityModel;


@end

@implementation VPTravelMainController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateSource =[NSMutableArray array];
    self.viewModel = [[VPTravelMainViewModel alloc] init];
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
#warning 添加地址和搜索
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityTravel) name:@"SelectCityNotification" object:nil];

    __weak typeof(VPTravelMainController) * weakSelf = self;
    //请求获取地址
    [[VPLocationManager sharedManager]
     loadRealCityListWithType:self.locationType success:^(NSArray *cityArray) {
//         __strong typeof(VPTravelMainController *)strongSelf = weakSelf;
         weakSelf.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:weakSelf.locationType];
         if(weakSelf.locationType == LocationCoordinateTypeTravel){
             weakSelf.locationAndSearchView = [[VPLocationAndSearchView alloc] initWithFrame:CGRectMake(0, 0, 235, 30)];
             weakSelf.navigationItem.titleView = weakSelf.locationAndSearchView;
             [weakSelf.locationAndSearchView.locationButton setTitle:weakSelf.cityModel.cityName forState:UIControlStateNormal];
             [weakSelf.locationAndSearchView.searchButton setTitle:@"输入旅游活动名称" forState:UIControlStateNormal];
             [weakSelf.locationAndSearchView layerUIBlock:^(NSInteger tag) {
                 if(tag == 1){
                     [weakSelf selectCityAction];
                 }else{
                     [weakSelf searchAction];
                 }
             }];
             weakSelf.navigationItem.rightBarButtonItem  = [self rightButton];

         }else if(weakSelf.locationType == LocationCoordinateTypeDestination){
             weakSelf.subSearchView = [[VPSubSearchView alloc] initWithFrame:CGRectMake(0, 0, 235, 30)];
             weakSelf.navigationItem.titleView = weakSelf.subSearchView;
             [weakSelf.subSearchView.searchButton setTitle:@"输入旅游活动名称" forState:UIControlStateNormal];
             [weakSelf.subSearchView layerUIBlock:^(NSInteger tag) {
                 //子页面的搜索
                 //搜索
                 [self searchAction];
                 NSLog(@"搜索");
             }];
             weakSelf.navigationItem.rightBarButtonItem  = [self rightButton];
         }
         
         VPTravelController *all = [VPTravelController instantiation];
         all.title =@"全部";
         all.locationType = weakSelf.locationType;
         all.tag = @"";
         all.sortType = @"2";
         [weakSelf.dateSource addObject:all];
         
         [weakSelf.viewModel travelTagschannelId:VPChannelTypeTravel success:^(NSArray *travelTagsArray) {
             for (VPTravelTagsModel *travelTagsModel in travelTagsArray) {
                 
                 VPTravelController *travelPlay = [VPTravelController instantiation];
                 travelPlay.title = travelTagsModel.tagName;
                 
                 travelPlay.locationType = weakSelf.locationType;
//                 travelPlay.provinceID =[NSString stringWithFormat:@"%ld",(long)travelTagsModel.parentID];
//                 travelPlay.city = strongSelf.city;
//                 travelPlay.location =strongSelf.location;
                 
                 travelPlay.sortType = @"2";
                 travelPlay.tag = [@(travelTagsModel.tagID) stringValue];
                 [weakSelf.dateSource addObject:travelPlay];
             }
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
             weakSelf.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.dateSource frame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) options:parameters];
             weakSelf.pageMenu.delegate = weakSelf;
             [weakSelf.view addSubview:weakSelf.pageMenu.view];
             [weakSelf addChildViewController:weakSelf.pageMenu];
         } failure:^(NSError *error) {
             [MBProgressHUD showTip:[error errorMessage]];
         }];
         } failure:^(NSError *error) {
             [MBProgressHUD showTip:error.errorMessage];
         }];
}

- (void)refreshCityTravel{
    self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    [self.locationAndSearchView.locationButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
}

-(void)filterAction{

    [self.traveUpSlideView showAnimation:YES];
}
#pragma mark -TravelUpSlideViewDelegate
- (void)selectIndex:(NSInteger)selectIndex{
//    0 热门 1 按距离 2 默认
    if (selectIndex==0) {
        NSDictionary * info =@{@"selectIndex":@"2"};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"VPRefreshTravelListDate" object:self userInfo:info];
    }else if (selectIndex==1){
        if(![VPLocationManager sharedManager].isLocation){
            [MBProgressHUD showTip:@"获取定位信息失败"];
            return;
        }
        NSDictionary * info =@{@"selectIndex":@"1"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VPRefreshTravelListDate" object:self userInfo:info];
        
    }else if (selectIndex==2){
    
        NSDictionary * info =@{@"selectIndex":@"0"};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"VPRefreshTravelListDate" object:self userInfo:info];
    }
}

#pragma mark -getter or setter
-(TravelUpSlideView *)traveUpSlideView{
    
    if (!_traveUpSlideView) {
        _traveUpSlideView =[[TravelUpSlideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _traveUpSlideView.delegate =self;
    }
    return _traveUpSlideView;
}

-(UIBarButtonItem *)rightButton{
    UIButton * customButton =[UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame =CGRectMake(0, 0, 40, 30);
    customButton.titleLabel.font =[UIFont systemFontOfSize:15];
    [customButton setTitleColor:[UIColor navigationTintColor] forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitle:@"筛选" forState:UIControlStateNormal];
    UIBarButtonItem *filterBarButton =[[UIBarButtonItem alloc]initWithCustomView:customButton];
    return filterBarButton;
}

- (void)searchAction{
    //判断是否带地址
    NSLog(@"搜索");
    VPSearchController *searchVC = [VPSearchController instantiation];
    searchVC.searchType = SearchTypeTravel;
    searchVC.cityID =self.cityModel.vid;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)selectCityAction{
    NSLog(@"选择城市");
    VPCityListController *cityVC = [VPCityListController instantiation];
    cityVC.locationType = LocationCoordinateTypeTravel;
    [self.navigationController pushViewController:cityVC animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
