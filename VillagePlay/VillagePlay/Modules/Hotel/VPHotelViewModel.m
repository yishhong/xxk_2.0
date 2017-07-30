//
//  VPHotelViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelViewModel.h"
#import "VPHotelAPI.h"
#import "YYModel.h"
#import "VPHotelListModel.h"
#import "QMCalendarFunction.h"

@interface VPHotelViewModel ()

@property(strong, nonatomic) NSMutableArray *dataSource;

@property(assign, nonatomic) NSInteger pageIndex;

@property(strong, nonatomic) VPHotelAPI *hotelAPI;

@property (strong, nonatomic) QMCalendarFunction *calendarFunction;

@property (assign, nonatomic) double startPrice;

@property (assign, nonatomic) double endPrice;

@property (assign, nonatomic) NSInteger orderByType;

@end

@implementation VPHotelViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.hotelAPI =[[VPHotelAPI alloc]init];
        self.calendarFunction =[[QMCalendarFunction alloc]init];
        self.pageIndex =0;
    }
    return self;
}


- (void)hotelListIsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    if (isFirstLoading) {
        self.pageIndex=0;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = cityModel.vid.length>0?cityModel.vid:@"";
    if([VPLocationManager sharedManager].isLocation){
        params[@"lon"] = @([VPLocationManager sharedManager].location.longitude);
        params[@"lat"] = @([VPLocationManager sharedManager].location.latitude);
    }else{
        params[@"lon"] = @"0";
        params[@"lat"] = @"0";
    }
    params[@"startPrice"] = @(self.startPrice);
    params[@"endPrice"] = @(self.endPrice);
    params[@"orderByType"] = @(self.orderByType);
    params[@"pageIndex"] = @(self.pageIndex);
    params[@"pageSize"] = @"20";

//    NSDictionary *parameters =@{
//                                @"city":cityModel.vid.length>0?cityModel.vid:@"",
//                                @"lon":@"112.890530",
//                                @"lat":@"28.210105",
//                                @"startPrice":@(self.startPrice),
//                                @"endPrice":@(self.endPrice),
//                                @"orderByType":@(self.orderByType),
//                                @"pageIndex":@(self.pageIndex),
//                                @"pageSize":@"20"
//                                };

    [self.hotelAPI hotelListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageIndex==0){
            [self.dataSource removeAllObjects];
        }
        NSArray * hotelArray =[NSArray yy_modelArrayWithClass:[VPHotelListModel class] json:responseDict[@"body"]];
        //布局
        //专题列表
        for (int i=0; i<hotelArray.count; i++) {
            VPHotelListModel * hotelListModel =hotelArray[i];
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelTableViewCell" height:316 dataSource:hotelListModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageIndex++;
        success([hotelArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
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

/**
 tag菜单
 
 @param startPrice 开始价格
 @param endPrice 结束价格
 */
- (void)hotelStartPrice:(double)hotelStartPrice hotelEndPrice:(double)hotelEndPrice{
    
    self.startPrice =hotelEndPrice;
    self.endPrice =hotelStartPrice;
}

/**
 排序
 @param orderByType 0默认排序，1价格由低到高，2距离排序
 */
- (void)orderByType:(NSInteger)orderByType{
    
    self.orderByType =orderByType;
}


@end
