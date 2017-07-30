//
//  TravelDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelDetailModel.h"
#import "VPTravelDetailAPI.h"
#import "VPUserManager.h"
#import "YYModel.h"
#import "UIColor+HUE.h"
#import "VPUserManager.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height


@interface TravelDetailModel()

@property(strong, nonatomic) NSMutableArray *dataSource;

@property(strong, nonatomic) VPTravelDetailAPI *travelDetailAPI;

@property (strong, nonatomic) VPActiveDetailModel *activeDetailModel;

@end

@implementation TravelDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource =[NSMutableArray array];
        self.travelDetailAPI =[[VPTravelDetailAPI alloc]init];
    }
    return self;
}

- (void)travelDetailID:(NSString *)travelID success:(void (^)())success failure:(void (^)(NSError *))failure{
    

    NSDictionary *params =@{@"version":@"v15",
                            @"id":travelID,
                            @"userid":[[VPUserManager sharedInstance]xx_userinfoID].length>0?[[VPUserManager sharedInstance]xx_userinfoID]:@" "};
    [self.travelDetailAPI travelDetailParams:params success:^(NSDictionary *responseDict) {
        
        self.activeDetailModel =[VPActiveDetailModel yy_modelWithJSON:responseDict[@"body"]];
        //活动信息
        
        NSMutableArray *travleArray =[NSMutableArray array];
        NSDictionary * activityStartTime =@{@"image":@"tab_ tour_calendar",
                                            @"title":[NSString stringWithFormat:@"活动开始时间:%@至%@",self.activeDetailModel.activeBeginTime,self.activeDetailModel.dateTime],
                                            @"hide":@""};
        [travleArray addObject:activityStartTime];
        NSDictionary * activityStopTime =@{@"image":@"tab_ tour_time",
                                           @"title":[NSString stringWithFormat:@"报名截止时间:%@",self.activeDetailModel.registerEndDate],
                                           @"hide":@""};
        [travleArray addObject:activityStopTime];
        
        NSDictionary * activityAddress =@{@"image":@"tab_ tour_location",
                                          @"title":[NSString stringWithFormat:@"活动地点:%@",self.activeDetailModel.address],
                                          @"hide":@"1"};
        [travleArray addObject:activityAddress];
        
        NSDictionary * activityTelephone =@{@"image":@"tab_ tour_photo",
                                            @"title":[NSString stringWithFormat:@"联系电话:%@",self.activeDetailModel.phoneNumber],
                                            @"hide":@"1"};
        [travleArray addObject:activityTelephone];
        //布局
        //旅游地名及价格
        XXCellModel *travelCellModel =[XXCellModel instantiationWithIdentifier:@"VPTravelDetailNameView" height:82 dataSource:self.activeDetailModel action:nil];
        [self.dataSource addObject:travelCellModel];
        
        //空行
        XXCellModel *lineCellMode =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellMode];
        for (NSDictionary * cellInfo in travleArray) {
            
            XXCellModel *travelDetail =[XXCellModel instantiationWithIdentifier:@"VPTravelDetailTableViewCell" height:46 dataSource:cellInfo action:nil];
            [self.dataSource addObject:travelDetail];
        }
        //空行
        XXCellModel *lineCellModel =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        
        XXCellModel *slideCellModel =[XXCellModel instantiationWithIdentifier:@"VPTravelDetailSlideTableViewCell" height:Main_Screen_Height-(64+40) dataSource:nil action:nil];
        [self.dataSource addObject:slideCellModel];
        success();
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

-(VPActiveDetailModel *)activeModel{

    return self.activeDetailModel;
}

@end
