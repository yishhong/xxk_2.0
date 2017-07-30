//
//  HBSearchViewModel.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HBSearchViewModel.h"
#import "YYModel.h"
#import "HBOrderAPI.h"
#import "HBStorageManager.h"
#import "NSString+Verify.h"

@interface HBSearchViewModel ()

@property (nonatomic, strong) HBSearchAPI *searchAPI;
@property (nonatomic, strong) HBOrderAPI *orderAPI;
@property (nonatomic, assign) NSInteger pageIndex;

/**
 *  搜索记录字符串
 */
@property (nonatomic, strong) NSMutableArray *searchRecordStrArray;

/**
 *  搜索历史记录数组(cell对象)
 */
@property (nonatomic, strong) NSMutableArray *searchRecordArray;

/**
 *  搜索结果数组
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  空数据的提示文本
 */
@property (nonatomic, copy) NSString *notDataStr;

@end

@implementation HBSearchViewModel

- (instancetype)init{
    
    self = [super init];
    if (self) {
        //初始化数据
        self.searchAPI = [[HBSearchAPI alloc] init];
        self.orderAPI = [[HBOrderAPI alloc] init];
        self.dataArray = [NSMutableArray array];
        self.pageIndex = 0;
        self.searchRecordStrArray = [NSMutableArray array];
        [self.searchRecordStrArray addObjectsFromArray:[HBStorageManager loadSearchRecord]];
        self.searchRecordArray = [NSMutableArray array];
        //加入清除按钮
        [self.searchRecordArray addObject:[self cellInfoWithCellName:@"HBSearchViewCleanCell"
                                                      withCellHeight:44
                                                          withAction:@selector(clearSearchRecord)
                                                            withInfo:nil]];
        for (NSString * searchRecordStr in self.searchRecordStrArray) {
            [self transformSearchRecordToModelForKey:searchRecordStr];
        }
        
        if([self.searchRecordStrArray count]>0){
            //如果有搜索记录就获取searchRecordArray中的数据
            self.dataArray = [self.searchRecordArray mutableCopy];
        }else{
            self.dataArray = [self.searchRecordStrArray mutableCopy];
        }
    }
    return self;
}

- (void)searchOrderWithFirst:(BOOL)isFirst success:(void (^)())success failure:(void (^)(NSError *))failure{
    //添加搜索历史记录
    if(self.searchText.length>0&&![self.searchText verifyEmpty])
    if(![self.searchRecordStrArray containsObject:self.searchText]){
        //添加到数据库中
        [HBStorageManager saveSearchRecord:self.searchText];
        //添加到数组中
        [self.searchRecordStrArray addObject:self.searchText];
        [self transformSearchRecordToModelForKey:self.searchText];
    }
    
    if (isFirst) {
        self.pageIndex=0;
        [self.dataArray removeAllObjects];
    }
    NSInteger hidIDInteger =[[HBUserManager sharedManager]hotelId];
    NSNumber *hidID = @(hidIDInteger);
    NSDictionary * params =@{@"hid":hidID,
                             @"key":self.searchText?:@"",
                             @"type":@(0),//默认为请求全部
                             @"pageIndex":@(self.pageIndex)?:@"",
                             };
    [self.searchAPI searchWithParams:params
                             success:^(NSDictionary *responseDict) {
                                 self.pageIndex++;
                                 NSArray * orderModelArray = [NSArray yy_modelArrayWithClass:[HBOrderModel class] json:responseDict[@"body"]];
                                 for (HBOrderModel *orderModel in orderModelArray) {
                                     [self transformSearchResultToModelForOrderModel:orderModel];
                                 }
                                 success();
                             } failure:^(NSError *error) {
                                 [self.dataArray removeAllObjects];
                                 failure(error);
                             }];
}

-(void)confirmPostOrderID:(NSString *)orderID status:(NSString *)status Success:(void(^)())success failure:(void(^)(NSError *error))failure{
    
    NSInteger sysid = [[HBUserManager sharedManager]sysUserId];
    NSDictionary * params =@{@"orderid":orderID,
                             @"sysid":@(sysid),
                             @"status":status};
    [self.orderAPI confirmOrderParams:params success:^(NSDictionary *responseDict) {
        
        success();
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

-(void)liveOrderID:(NSString *)orderID success:(void(^)())success failure:(void(^)(NSError *error))failure{
    NSDictionary * params = @{@"orderid":orderID};
    [self.orderAPI liveOrderParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)showSearchRecord:(NSInteger)isShow{
//    NSString *str=@"";
    switch (isShow) {
        case 1:{
            self.notDataStr = @"暂无搜索记录";

        }break;
        case 0:{
            self.notDataStr = @"很抱歉，没有找到匹配结果";

        }break;
        case -1:{
            self.notDataStr = @"连接失败，请检查网络后重试";
        }break;
        default:
            break;
    }
}

-(NSString *)fetchNotDataString{
    return self.notDataStr;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (NSDictionary *)cellInfoInRow:(NSInteger )index{
    return [self.dataArray objectAtIndex:index];
}

- (void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    if(searchText.length == 0){
        //处理dataArray的数据 
        if([self.searchRecordStrArray count]>0){
            self.dataArray = [self.searchRecordArray mutableCopy];
        }else{
            self.dataArray = [self.searchRecordStrArray mutableCopy];
        }
    }
}

//转化搜索记录
- (void)transformSearchRecordToModelForKey:(NSString *)key{
    HBSearchCellInfoModel *cellInfoModel = [self cellInfoWithCellName:@"HBSearchViewTitleCell"
                                                       withCellHeight:44.0f
                                                           withAction:@selector(selectSearchRecord:)
                                                             withInfo:@{@"title":key}];
    [self.searchRecordArray insertObject:cellInfoModel atIndex:0];
}
//转化搜索结果
- (void)transformSearchResultToModelForOrderModel:(HBOrderModel *)orderModel{
    float height = 0.0f;
    if (orderModel.orderState ==5) {
        height = 160;
    }else{
        height =  210;
    }
    HBSearchCellInfoModel *cellInfoModel = [self cellInfoWithCellName:@"HBOrderTableTableViewCell"
                                                       withCellHeight:height
                                                           withAction:@selector(selectSearchResult:)
                                                             withInfo:orderModel];
    cellInfoModel.VCName = @"HBOrderDatailViewController";
    [self.dataArray addObject:cellInfoModel];
}

- (void)clearSearchRecord{
    //清理数据，包括本地的
    [self.searchRecordStrArray removeAllObjects];
    //清除搜索记录的cell对象
    [self.searchRecordArray removeAllObjects];
    //加上搜索记录的清除按钮
    [self.searchRecordArray addObject:[self cellInfoWithCellName:@"HBSearchViewCleanCell"
                                                  withCellHeight:44
                                                      withAction:@selector(clearSearchRecord)
                                                        withInfo:nil]];
    
    [self.dataArray removeAllObjects];
    [HBStorageManager deleteSearchRecord];
}

//创建cell的字典
- (HBSearchCellInfoModel *)cellInfoWithCellName:(NSString *)cellName withCellHeight:(float)height withAction:(SEL)action withInfo:(id)info{
    HBSearchCellInfoModel *cellInfoModel = [[HBSearchCellInfoModel alloc] init];
    cellInfoModel.identifier = cellName;
    cellInfoModel.action = action;
    cellInfoModel.info = info;
    cellInfoModel.height = height;
    return cellInfoModel;
}
@end
