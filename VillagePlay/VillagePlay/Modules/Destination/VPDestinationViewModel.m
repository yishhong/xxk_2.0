//
//  VPDestinationViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationViewModel.h"
#import "VPTravelAPI.h"
#import "VPPlayAPI.h"
#import "VPVillageAPI.h"
#import "VPHotelAPI.h"
#import "VPBannerAPI.h"
#import "VPBannerInfoModel.h"
#import "VPPlayListModel.h"
#import "VPActiveModel.h"
#import "VPVillageModel.h"
#import "VPHotelListModel.h"
#import "QMCalendarFunction.h"
#import "NSError+Reason.h"

@interface VPDestinationViewModel ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) VPBannerAPI *bannerAPI;
@property (nonatomic, strong) VPPlayAPI *playAPI;
@property (nonatomic, strong) VPTravelAPI *traveAPI;
@property (nonatomic, strong) VPVillageAPI *villageAPI;
@property (nonatomic, strong) VPHotelAPI *hotelAPI;

@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *memuArray;
@property (nonatomic, strong) NSMutableArray *playArray;
@property (nonatomic, strong) NSMutableArray *traveArray;
@property (nonatomic, strong) NSMutableArray *hotelArray;
@property (nonatomic, strong) NSMutableArray *villageArray;

@property (strong, nonatomic) QMCalendarFunction *calendarFunction;


@end

@implementation VPDestinationViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.calendarFunction =[[QMCalendarFunction alloc]init];
        self.dataSource = [NSMutableArray array];
        self.bannerAPI = [[VPBannerAPI alloc] init];
        self.traveAPI = [[VPTravelAPI alloc] init];
        self.playAPI = [[VPPlayAPI alloc] init];
        self.villageAPI = [[VPVillageAPI alloc] init];
        self.hotelAPI = [[VPHotelAPI alloc] init];
        self.bannerArray = [NSMutableArray array];
        self.memuArray = [NSMutableArray array];
        self.playArray = [NSMutableArray array];
        self.traveArray = [NSMutableArray array];
        self.hotelArray = [NSMutableArray array];
        self.villageArray = [NSMutableArray array];
        
        [self.dataSource addObject:self.bannerArray];
        [self.dataSource addObject:self.memuArray];
        [self.dataSource addObject:self.playArray];
        [self.dataSource addObject:self.traveArray];
        [self.dataSource addObject:self.hotelArray];
        [self.dataSource addObject:self.villageArray];
    }
    return self;
}

- (void)configOptions{
    [self.memuArray removeAllObjects];
    NSMutableArray *optionsArray = [NSMutableArray array];
    [optionsArray addObject:@{@"title":@"乡村",@"icon":@"vp_btn_destination_rural",@"action":@"menuVillage"}];
    [optionsArray addObject:@{@"title":@"民宿",@"icon":@"vp_btn_destination_hotel",@"action":@"menuHotel"}];
    [optionsArray addObject:@{@"title":@"门票",@"icon":@"vp_btn_destination_ticket",@"action":@"menuTicket"}];
    
    XXCellModel *menuModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendMenuCell" height:95 dataSource:optionsArray action:nil];
    [self.memuArray addObject:menuModel];
    XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
    [self.memuArray addObject:spaceModel];

}

- (void)loadDestinationBannerSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    [self.bannerAPI loadCityBannerWithCityID:cityModel.vid.length>0?[cityModel.vid integerValue]:0 success:^(NSDictionary *responseDict) {
        NSArray *bannerArray = [NSArray yy_modelArrayWithClass:[VPBannerInfoModel class] json:responseDict[@"body"]];
        if([bannerArray count]>0){
            [self.bannerArray removeAllObjects];
            [self.memuArray removeAllObjects];
            [self.playArray removeAllObjects];
            [self.traveArray removeAllObjects];
            [self.hotelArray removeAllObjects];
            [self.villageArray removeAllObjects];
            [self.bannerArray removeAllObjects];
            XXCellModel *bannerModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendBannerCell" height:210 dataSource:bannerArray action:nil];
            bannerModel.title= @"目的地";
            [self.bannerArray addObject:bannerModel];
            [self configOptions];
            success();
        }else{
            failure([NSError errorMessage:@"数据加载异常!"]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    

}
- (void)loadDestinationPlaySuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    //精选游玩列表
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];

    NSDictionary *params=@{
                           @"cityId":cityModel.vid.length>0?cityModel.vid:@"0",
                           @"pageNum":@(1),
                           @"pageSize":@(4)
                           };
    [self.playAPI playListParams:params success:^(NSDictionary *responseDict) {
        [self.playArray removeAllObjects];
        NSArray * playArray =[NSArray yy_modelArrayWithClass:[VPPlayListModel class] json:responseDict[@"body"]];
        if([playArray count]>0){
            
            XXCellModel *palyTitleModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationTitleCell" height:55 dataSource:@"精选玩法" action:nil];
            [self.playArray addObject:palyTitleModel];
            for (VPPlayListModel*playListModel in playArray) {
                XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationPlayCell" height:140 dataSource:playListModel action:nil];
                [self.playArray addObject:cellModel];
            }
            //设置改模块最后的线条样式
            XXCellModel * lastCellModel =[self.playArray lastObject];
            lastCellModel.location = CellLocationEnd;
            //添加更多
            XXCellModel *palyMoreModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(morePlay)];
            [self.playArray addObject:palyMoreModel];
            //添加空行
            XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
            [self.playArray addObject:spaceModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadDestinationTraveSuccess:(void (^)())success failure:(void (^)(NSError *))failure{

    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"version"] = @"v15";
    params[@"city"] = cityModel.vid.length>0?cityModel.vid:@"0";
    params[@"pageNum"] = @(1);
    params[@"pageSize"] = @(4);
    if([VPLocationManager sharedManager].isLocation){
        params[@"location"] = [QMMapFuntion transformCoordinateLocationString:[VPLocationManager sharedManager].location];
    }
//    NSDictionary *params =@{
//                            @"version":@"v15",
//                            @"city":cityModel.vid.length>0?cityModel.vid:@"0",
////                            @"isSuggest":isSuggest?:@"",
////                            @"sortType":sortType?:@"",
//                            @"pageNum":@(1),
//                            @"pageSize":@(4),
//                            @"location":location?:@"",
////                            @"tag":tag?:@""
//                            };
    [self.traveAPI travelListParams:params success:^(NSDictionary *responseDict) {
        [self.traveArray removeAllObjects];
        NSArray * travelArray =[NSArray yy_modelArrayWithClass:[VPActiveModel class] json:responseDict[@"body"]];
        
        if([travelArray count]>0){
            //专题列表
            XXCellModel *activityTitleModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationTitleCell" height:55 dataSource:@"当地活动" action:nil];
            [self.traveArray addObject:activityTitleModel];
            
            for (int i=0; i<travelArray.count; i++) {
                VPActiveModel *travelModel = travelArray[i];
                XXCellModel *activityModel = [XXCellModel instantiationWithIdentifier:@"VPTravelTableViewCell" height:340 dataSource:travelModel action:nil];
                [self.traveArray addObject:activityModel];
            }
            //更多
            XXCellModel *activityMoreModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(moreActivity)];
            [self.traveArray addObject:activityMoreModel];
            //添加空行
            XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
            [self.traveArray addObject:spaceModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadDestinationHotelSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
#warning 经纬度可以传0 位置为位置
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"city"] = cityModel.vid>0?cityModel.vid:@"0";
    if([VPLocationManager sharedManager].isLocation){
        params[@"location"] = [QMMapFuntion transformCoordinateLocationString:[VPLocationManager sharedManager].location];
    }
    params[@"lon"] = @([VPLocationManager sharedManager].location.longitude)?:0;
    params[@"lat"] = @([VPLocationManager sharedManager].location.latitude)?:0;
    params[@"startPrice"] = @(0);
    params[@"endPrice"] = @(0);
    params[@"pageIndex"] = @(0);
    params[@"pageSize"] = @(5);
    if([VPLocationManager sharedManager].isLocation){
        params[@"location"] = [QMMapFuntion transformCoordinateLocationString:[VPLocationManager sharedManager].location];
    }

//    NSDictionary *params =@{
//                            @"city":cityModel.vid>0?cityModel.vid:@"0",
//                            @"lon":@(112.890530),
//                            @"lat":@(28.210105),
//                            @"startPrice":@(0),
//                            @"endPrice":@(0),
//                            @"pageIndex":@(0),
//                            @"pageSize":@(4)
//                            };
    [self.hotelAPI hotelListParams:params success:^(NSDictionary *responseDict) {
        NSArray * hotelArray =[NSArray yy_modelArrayWithClass:[VPHotelListModel class] json:responseDict[@"body"]];
        if([hotelArray count]>0){
            [self.hotelArray removeAllObjects];
            XXCellModel *hotleTitleModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationTitleCell" height:55 dataSource:@"推荐民宿" action:nil];
            [self.hotelArray addObject:hotleTitleModel];
            
            XXCellModel *hotleCellModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationHotelCell" height:295 dataSource:hotelArray action:nil];
            [self.hotelArray addObject:hotleCellModel];
            //添加空行
            XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
            [self.hotelArray addObject:spaceModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)loadDestinationVillageSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    
    NSString *location = [QMMapFuntion transformCoordinateLocationString:[VPLocationManager sharedManager].location];


    NSDictionary *params =@{
                            @"version":@"v14",//历史遗留问题按理说这里是不需要V14
                            @"city":cityModel.vid.length>0?cityModel.vid:@"0",//城市ID 需要拿到城市ID 目前写死
                            @"provinceID":@"",//省ID 目前可不需要
                            @"type":@(2),//精选类型
//                            @"tag":@(0),//村庄的Tag 条件查询
                            @"location":location.length>0?location:@"", // 配合sortType参数使用，当需要按距离排序时需要传递
                            @"pageNum":@(1),
                            @"pageSize":@(6),
                            @"sortType":@(2),//数据排序的方式
                            };
    [self.villageAPI villageListParams:params success:^(NSDictionary *responseDict) {
        //必玩村庄
        [self.villageArray removeAllObjects];
        NSArray * villageArray =[NSArray yy_modelArrayWithClass:[VPVillageModel class] json:responseDict[@"body"]];
        if([villageArray count]>0){
            XXCellModel *villageTitleModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationTitleCell" height:55 dataSource:@"必玩乡村" action:nil];
            [self.villageArray addObject:villageTitleModel];
            for (int i=0; i<villageArray.count; i+=3) {
                NSUInteger len = 3;
                if(i+3>[villageArray count]){
                    len= [villageArray count]-i;
                }
                XXCellModel *villageModel = [XXCellModel instantiationWithIdentifier:@"VPDestinationVillageCell" height:192 dataSource:[villageArray subarrayWithRange:NSMakeRange(i, len)] action:nil];
                [self.villageArray addObject:villageModel];
            }
            //更多
            XXCellModel *villageMoreModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(moreVillage)];
            [self.villageArray addObject:villageMoreModel];
            XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
            [self.villageArray addObject:spaceModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSInteger)numberOfSections{
    return [self.dataSource count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource objectAtIndex:section] count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.section][indexPath.row];
}

//TODO:这里需要修改 统一一个模式
- (NSDictionary *)dateTimeInfo{
    
    //使用日期
    NSString * todayString =[self.calendarFunction getCurrentTime];
    NSString * tomorrowDayString =[self.calendarFunction GetTomorrowDay:[NSDate date]];
    //转成MM-dd
    NSString * todayTime =[self.calendarFunction currentDatefromString:todayString];
    NSString *tomorrowTime =[self.calendarFunction currentDatefromString:tomorrowDayString];
    NSDictionary *dateInfo=@{@"todayDate":todayString,
                             @"tomorrowDate":tomorrowDayString,
                             @"todayTime":todayTime,
                             @"tomorrowTime":tomorrowTime};
    return dateInfo;
}

@end
