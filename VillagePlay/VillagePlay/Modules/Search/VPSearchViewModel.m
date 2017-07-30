    //
//  VPSearchViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewModel.h"
#import "VPSearchAPI.h"
#import "VPSearchModel.h"
#import "QMCalendarFunction.h"
#import "VPStorageManager.h"

#import "MBProgressHUD+Loading.h"

@interface VPSearchViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPSearchAPI *searchAPI;
@property (strong, nonatomic) NSMutableArray *allArray;
@property (strong, nonatomic) NSMutableArray *hotelArray;
@property (strong, nonatomic) NSMutableArray *ticketArray;
@property (strong, nonatomic) NSMutableArray *travelArray;
@property (strong, nonatomic) NSMutableArray *villageArray;

@property (assign, nonatomic) NSInteger pageNum;
@property (assign, nonatomic) NSInteger pageSize;

@property (strong, nonatomic) QMCalendarFunction *calendarFunction;

/**
 *  搜索记录字符串
 */
@property (nonatomic, strong) NSMutableArray *searchRecordStrArray;

/**
 *  搜索历史记录数组(cell对象)
 */
@property (nonatomic, strong) NSMutableArray *searchRecordArray;

/**
 *  空数据的提示文本
 */
@property (nonatomic, copy) NSString *notDataStr;



@end

@implementation VPSearchViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.pageNum = 1;
        self.pageSize = 20;
        self.calendarFunction =[[QMCalendarFunction alloc]init];
        self.dataSource = [NSMutableArray array];
        self.searchAPI = [[VPSearchAPI alloc] init];
        self.villageArray = [NSMutableArray array];
        self.travelArray = [NSMutableArray array];
        self.ticketArray = [NSMutableArray array];
        self.hotelArray = [NSMutableArray array];
        self.allArray = [NSMutableArray array];
        
        self.searchRecordStrArray = [NSMutableArray array];
        [self.searchRecordStrArray addObjectsFromArray:[VPStorageManager loadSearchRecord]];
        self.searchRecordArray = [NSMutableArray array];
        //加入清除按钮
//        [self.searchRecordArray addObject:[self cellInfoWithCellName:@"HBSearchViewCleanCell"
//                                                      withCellHeight:44
//                                                          withAction:@selector(clearSearchRecord)
//                                                            withInfo:nil]];

    }
    return self;
}
- (void)setSearchType:(SearchType)searchType{
    _searchType = searchType;
    switch (searchType) {
        case SearchTypeAll:{
            [self.dataSource addObject:self.villageArray];
            [self.dataSource addObject:self.travelArray];
            [self.dataSource addObject:self.hotelArray];
            [self.dataSource addObject:self.ticketArray];
        }break;
        case SearchTypeHotel:{
            [self.dataSource addObject:self.hotelArray];
        }break;
        case SearchTypeTicket:{
            [self.dataSource addObject:self.ticketArray];
        }break;
        case SearchTypeTravel:{
            [self.dataSource addObject:self.travelArray];
        }break;
        case SearchTypeVillage:{
            [self.dataSource addObject:self.villageArray];
        }break;
        default:
            break;
    }
}
- (void)loadSearchWithIsFirs:(BOOL)isFirst success:(void (^)(BOOL ,NSString *))success failure:(void (^)(NSError *))failure{
    
    if(isFirst){
        self.pageNum = 1;
        [self.hotelArray removeAllObjects];
        [self.villageArray removeAllObjects];
        [self.travelArray removeAllObjects];
        [self.ticketArray removeAllObjects];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = self.searchText;
    if(self.cityID.length>0){
        params[@"city"] = self.self.cityID;
    }
    __block NSString *message = @"";
    switch (self.searchType) {
        case SearchTypeAll:{
            params[@"top"] = @(20);
            [self.searchAPI loadSearchAllWithParams:params success:^(NSDictionary *responseDict) {
                NSArray *hotelArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"][@"hlist"]];
                [self hotel:hotelArray];
                if([hotelArray count]>0){
//                    XXCellModel * moreCellModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(hotelMore)];
//                    [self.hotelArray addObject:moreCellModel];
                    XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
                    [self.hotelArray addObject:spaceCellModel];
                }
                
                NSArray *ticketArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"][@"tlist"]];
                [self ticket:ticketArray];
                if([ticketArray count]>0){
//                    XXCellModel * moreCellModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(ticketMore)];
//                    [self.ticketArray addObject:moreCellModel];
                    XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
                    [self.ticketArray addObject:spaceCellModel];
                }
                
                NSArray *travelArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"][@"alist"]];
                [self travel:travelArray];
                if([travelArray count]>0){
//                    XXCellModel * moreCellModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(travelMore)];
//                    [self.travelArray addObject:moreCellModel];
                    XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
                    [self.travelArray addObject:spaceCellModel];
                }
                
                NSArray *villageArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"][@"vlist"]];
                [self village:villageArray];
                if([villageArray count]>0){
//                    XXCellModel * moreCellModel = [XXCellModel instantiationWithIdentifier:@"VPListMoreCell" height:44 dataSource:nil action:@selector(villageMore)];
//                    [self.villageArray addObject:moreCellModel];
                    XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
                    [self.villageArray addObject:spaceCellModel];
                }
                if([hotelArray count]==0&&[villageArray count]==0&&[travelArray count]==0&&[ticketArray count]==0){
                    message = @"暂时没有找到相关信息";
                }
                success(NO,message);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        case SearchTypeHotel:{
            params[@"pageNum"] = @(self.pageNum);
            params[@"pageSize"] = @(self.pageSize);
            [self.searchAPI loadSearchHotelWithParams:params success:^(NSDictionary *responseDict) {
                NSArray *hotelArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"]];
                [self hotel:hotelArray];
                if([self.hotelArray count]==0&&self.pageNum==1){
                    message = @"暂时没有找到相关信息";
                }
                self.pageNum++;
                success([hotelArray count]<1?NO:YES,message);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        case SearchTypeTicket:{
            params[@"pageNum"] = @(self.pageNum);
            params[@"pageSize"] = @(self.pageSize);
            [self.searchAPI loadSearchTicketWithParams:params success:^(NSDictionary *responseDict) {
                NSArray *ticketArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"]];
                [self ticket:ticketArray];
                if([self.ticketArray count]==0&&self.pageNum==1){
                    message = @"暂时没有找到相关信息";
                }
                self.pageNum++;
                success([ticketArray count]<1?NO:YES,message);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        case SearchTypeTravel:{
            params[@"pageNum"] = @(self.pageNum);
            params[@"pageSize"] = @(self.pageSize);
            [self.searchAPI loadSearchActiveWithParams:params success:^(NSDictionary *responseDict) {
                NSArray *activeArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"]];
                [self travel:activeArray];
                if([self.travelArray count]==0&&self.pageNum==1){
                    message = @"暂时没有找到相关信息";
                }
                self.pageNum++;
                success([activeArray count]<1?NO:YES,message);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        case SearchTypeVillage:{
            params[@"pageNum"] = @(self.pageNum);
            params[@"pageSize"] = @(self.pageSize);
            [self.searchAPI loadSearchVillageWithParams:params success:^(NSDictionary *responseDict) {
                NSArray *villageArray = [NSArray yy_modelArrayWithClass:[VPSearchModel class] json:responseDict[@"body"]];
                [self village:villageArray];
                if([self.villageArray count]==0&&self.pageNum==1){
                    message = @"暂时没有找到相关信息";
                }
                self.pageNum++;
                success([villageArray count]<1?NO:YES,message);
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        default:
            break;
    }
}

- (void)hotel:(NSArray *)hotelArray{
    if(([hotelArray count]>0&&self.searchType == SearchTypeAll)||([self.hotelArray count]==0&&self.searchType == SearchTypeHotel&&[hotelArray count]>0)){
        XXCellModel *titleCellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewModuleTitleCell" height:30 dataSource:@"民宿" action:nil];
        [self.hotelArray addObject:titleCellModel];
    }
    for (VPSearchModel *searchModel in hotelArray) {
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewHotelCell" height:104 dataSource:searchModel action:@selector(hotel:)];
        [self.hotelArray addObject:cellModel];
    }
}

- (void)ticket:(NSArray *)ticketArray{
    if(([ticketArray count]>0&&self.searchType == SearchTypeAll)&&([self.ticketArray count]==0&&self.searchType==SearchTypeTicket&&[ticketArray count]>0)){
        XXCellModel *titleCellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewModuleTitleCell" height:30 dataSource:@"门票" action:nil];
        [self.ticketArray addObject:titleCellModel];
    }
    for (VPSearchModel *searchModel in ticketArray) {

        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewTicketCell" height:104 dataSource:searchModel action:@selector(ticket:)];
        [self.ticketArray addObject:cellModel];
    }
}

- (void)travel:(NSArray *)travelArray{
    if(([travelArray count]>0&&self.searchType == SearchTypeAll)||([self.travelArray count]==0&&self.searchType == SearchTypeTravel&&[travelArray count]>0)){
        XXCellModel *titleCellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewModuleTitleCell" height:30 dataSource:@"活动" action:nil];
        [self.travelArray addObject:titleCellModel];
    }
    for (VPSearchModel *searchModel in travelArray) {
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewTravelCell" height:104 dataSource:searchModel action:@selector(travel:)];
        [self.travelArray addObject:cellModel];
    }
}

- (void)village:(NSArray *)villageArray{
    if(([villageArray count]>0&&self.searchType == SearchTypeAll)||([self.villageArray count]==0&&self.searchType == SearchTypeVillage&&[villageArray count]>0)){
        XXCellModel *titleCellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewModuleTitleCell" height:30 dataSource:@"乡村" action:nil];
        [self.villageArray addObject:titleCellModel];
    }
    for (VPSearchModel *searchModel in villageArray) {
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPSearchViewVillageCell" height:104 dataSource:searchModel action:@selector(village:)];
        [self.villageArray addObject:cellModel];
    }
}

- (NSInteger)numberOfSections{
    return [self.dataSource count];
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
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
