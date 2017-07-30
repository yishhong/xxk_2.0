//
//  VPTravelViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelViewModel.h"
#import "VPTravelAPI.h"
#import "VPActiveModel.h"
#import "YYModel.h"


@interface VPTravelViewModel ()

@property(strong, nonatomic)NSMutableArray * dataSource;

@property(strong, nonatomic)VPTravelAPI *travelAPI;

@property(assign, nonatomic)NSInteger pageNum;

@end

@implementation VPTravelViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.travelAPI =[[VPTravelAPI alloc]init];
        self.pageNum =1;
    }
    return self;
}


-(void)travelListprovinceID:(NSString *)provinceID city:(NSString *)city isSuggest:(NSString *)isSuggest sortType:(NSString *)sortType location:(NSString *)location tag:(NSString *)tag IsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL ))success failure:(void (^)(NSError *))failure{
    
    VPOpenCityInfoModel *cityModel = nil;
    if(self.locationType == LocationCoordinateTypeNow){
        cityModel = [[VPOpenCityInfoModel alloc] init];
        cityModel.vid = 0;
    }else{
        cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    }
    
    if (isFirstLoading) {
        self.pageNum =1;
    }

    NSDictionary *parameters = @{@"version":@"v15",
//                                 @"provinceID":provinceID?:@"",
//                                 @"city":cityModel.vid.length>0?cityModel.vid:@"",
                                 @"isSuggest":isSuggest?:@"",
                                 @"sortType":sortType?:@"",
                                 @"pageNum":@(self.pageNum),
                                 @"pageSize":@(20),
                                 @"location":location?:@"",
                                 @"tag":tag?:@""
                                 };
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if(params){
        if([VPLocationManager sharedManager].isLocation){
            params[@"location"] = [QMMapFuntion transformCoordinateLocationString:[VPLocationManager sharedManager].location];
        }else{
            params[@"location"] = @"";
        }
        //选中城市的参数
        NSString *cityID = @"";
        if(cityModel.vid.length>0){
            if(![cityModel.vid isEqualToString:@"0"]){
                cityID = cityModel.vid;
            }
        }
        params[@"city"] = cityID;
    }
    

    [self.travelAPI travelListParams:params success:^(NSDictionary *responseDict) {
        NSArray * travelArray =[NSArray yy_modelArrayWithClass:[VPActiveModel class] json:responseDict[@"body"]];
        if(self.pageNum ==1){
            [self.dataSource removeAllObjects];
        }
        //布局
        //专题列表
        for (int i=0; i<travelArray.count; i++) {
            VPActiveModel *travelModel = travelArray[i];
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPTravelTableViewCell" height:340 dataSource:travelModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageNum++;
        success([travelArray count]==0?NO:YES);
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


@end
