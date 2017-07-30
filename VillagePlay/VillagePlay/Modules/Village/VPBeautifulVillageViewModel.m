//
//  VPBeautifulVillageViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBeautifulVillageViewModel.h"
#import "VPVillageAPI.h"
#import "VPVillageModel.h"
#import "YYModel.h"
#import "VPTagsModel.h"
#import "CommentDetaileEnum.h"

@interface VPBeautifulVillageViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPVillageAPI *villageAPI;
@property (assign, nonatomic) NSInteger pageNum;
@property (assign, nonatomic) NSInteger sortType;
@property (strong, nonatomic) NSString *villageTag;
@end

@implementation VPBeautifulVillageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dataSource = [NSMutableArray array];
        self.villageAPI =[[VPVillageAPI alloc]init];
        self.villageTag = @"全部";
        self.sortType =2;
    }
    return self;
}

- (void)villageTagListSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"channelId"] = @(VPChannelTypeVillage);
    [self.villageAPI villageTagListParams:params success:^(NSDictionary *responseDict) {
        NSMutableArray * tagsArray =[[NSArray yy_modelArrayWithClass:[VPTagsModel class] json:responseDict[@"body"]] mutableCopy];
        VPTagsModel *tagsModel = [[VPTagsModel alloc] init];
        tagsModel.name = @"全部";
        VPTagModel *tagModel = [[VPTagModel alloc] init];
        tagModel.tagName = @"全部";
        tagModel.tagId = 0;
        tagsModel.tags = @[tagModel];
        [tagsArray insertObject:tagsModel atIndex:0];
        success(tagsArray);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)villageListWithIsFirst:(BOOL)isFirst success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    if (isFirst) {
        self.pageNum = 1;
    }
    
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];

    NSMutableDictionary *params =[NSMutableDictionary dictionaryWithDictionary:@{
                                                                                 @"version":@"v14",//历史遗留问题按理说这里是不需要V14
                                                                                 @"city":cityModel.vid.length>0?cityModel.vid:@"",//城市ID 目前写死
                                                                                 @"provinceID":@"",//省ID 目前可不需要
                                                                                 @"type":@(self.type),//精选类型
                                                                                 @"tag":self.villageTag?:@"",//村庄的Tag 条件查询 如果有选择村庄tag就传改参数 否则不传
                                                                                 @"location":@"", // 配合sortType参数使用，当需要按距离排序时需要传递
                                                                                 @"pageNum":@(self.pageNum),
                                                                                 @"pageSize":@"20",
                                                                                 @"sortType":@(self.sortType),//数据排序的方式
                                                                                 }];
    
    if([self.villageTag isEqualToString:@"全部"]){
        params[@"tag"] = @"";
    }
    //设置是否精选的
    if(self.type ==2){
        params[@"type"] = @(self.type);
    }else{
        //如果不为精选移除
        [params removeObjectForKey:@"type"];
    }
    //设置距离
    if([VPLocationManager sharedManager].isLocation){
        params[@"location"] = [QMMapFuntion transformCoordinateLocationString:[VPLocationManager sharedManager].location];
    }
    
    [self.villageAPI villageListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageNum ==1){
            [self.dataSource removeAllObjects];
        }
        NSArray * villageArray =[NSArray yy_modelArrayWithClass:[VPVillageModel class] json:responseDict[@"body"]];
        //布局
        //专题列表
        for (int i=0; i<villageArray.count; i++) {
            VPVillageModel *villageModel =villageArray[i];
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"BeautifulVillageTableViewCell" height:211 dataSource:villageModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageNum++;
        success([villageArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 tag刷新
 
 @param tagName tag名
 */
- (void)villageTagName:(NSString *)tagName{
    if ([tagName isEqualToString:@"全部"]) {
        tagName =@"";
    }
    self.villageTag =tagName;
}

/**
 排序
 @param sortType 排序 0 热门 1 按距离 2 默认
 */
-(void)sortType:(NSInteger)sortType{
    
    //    0 热门 1 按距离 2 默认
    self.sortType=sortType;
    
}


-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}

@end
