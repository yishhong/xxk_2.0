//
//  VPRefundApplyViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRefundApplyViewModel.h"
#import "VPUserManager.h"
#import "VPTravelOrderDetailAPI.h"

@interface VPRefundApplyViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong ,nonatomic) VPTravelOrderDetailAPI *travelOrderDetailAPI;

@end

@implementation VPRefundApplyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.travelOrderDetailAPI =[[VPTravelOrderDetailAPI alloc]init];
    }
    return self;
}
- (void)layerUI:(NSArray *)refundApplyViewModel{
//    NSArray * refundReason =@[@{@"title":@"退款原因(至少选取一项)"},
//                              @{@"title":@"其他,请手动填写"}];
    //布局
    //退款原因节
//    XXCellModel * traveOrderCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:refundReason[0] action:nil];
//    [self.dataSource addObject:traveOrderCellModel];
//    //退款原因
//    for (NSDictionary *refundInfo in refundArray) {
//        XXCellModel * refundReasonCellModel = [XXCellModel instantiationWithIdentifier:@"TravelRefundReasonTableViewCell" height:44 dataSource:refundInfo action:nil];
//        [self.dataSource addObject:refundReasonCellModel];
//    }
//    XXCellModel * otherOrderCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:refundReason[1] action:nil];
//    [self.dataSource addObject:otherOrderCellModel];
    //退款理由
//    XXCellModel * WritRefundReasonCellModel = [XXCellModel instantiationWithIdentifier:@"TravelWritRefundReasonTableViewCell" height:150 dataSource:nil action:nil];
//    [self.dataSource addObject:WritRefundReasonCellModel];
    //提交理由
    XXCellModel * submitRefundReasoncellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderSubmitRefundReasonTableViewCell" height:140 dataSource:nil action:nil];
    [self.dataSource addObject:submitRefundReasoncellModel];
}


- (void)travelRefunReason:(NSString *)refundReason orderNum:(NSString *)orderNum success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSDictionary * parameters = @{@"version":@"v15",
                                  @"userID":[[VPUserManager sharedInstance] xx_userinfoID],
                                  @"refundReason":refundReason,
                                  @"orderNum":orderNum
                                  };
    [self.travelOrderDetailAPI travelRefundParams:parameters success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.dataSource[indexPath.row];
}

- (NSArray *)refundReason{

    NSArray*refundArray =@[@"预约不上",@"去过,不太满意",@"买多了/买错了",@"计划有变,没时间消费",@"后悔了不想买了"];
    return refundArray;
}

@end
