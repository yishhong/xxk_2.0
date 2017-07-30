//
//  VPCouponViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponViewModel.h"
#import "VPCouponAPI.h"
#import "VPCouponModel.h"
#import "VPUserManager.h"

@interface VPCouponViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPCouponAPI * couponAPI;
@end

@implementation VPCouponViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.couponAPI = [[VPCouponAPI alloc] init];
    }
    return self;
}

- (void)loadCouponListSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    [self.couponAPI loadCouponListWithUserID:[VPUserManager sharedInstance].xx_userinfoID status:self.state success:^(NSDictionary *responseDict) {
#warning 目前接口没有分页的概念 所以这里直接把数据移除
        [self.dataSource removeAllObjects];
        
        NSArray *array = [NSArray yy_modelArrayWithClass:[VPCouponModel class] json:responseDict[@"body"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSDateFormatter *transformFormatter = [[NSDateFormatter alloc] init];
        [transformFormatter setDateFormat:@"yyyy-MM-dd"];

        for (VPCouponModel *couponModel in array) {
            couponModel.xx_couponState = self.state;
            couponModel.startTime = [transformFormatter stringFromDate:[formatter dateFromString:couponModel.startTime]];
            couponModel.closingTime = [transformFormatter stringFromDate:[formatter dateFromString:couponModel.closingTime]];
            XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPCouponCell" height:130 dataSource:couponModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)layerUI{
    for (int i =0; i< 10; i++) {
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPCouponCell" height:130 dataSource:nil action:nil];
        [self.dataSource addObject:cellModel];
    }
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}
@end
