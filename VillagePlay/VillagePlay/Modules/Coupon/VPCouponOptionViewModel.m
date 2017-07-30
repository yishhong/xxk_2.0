//
//  VPCouponOptionViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponOptionViewModel.h"
#import "VPCouponAPI.h"
#import "VPUserManager.h"

@interface VPCouponOptionViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPCouponAPI *couponAPI;

@end

@implementation VPCouponOptionViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.couponAPI = [[VPCouponAPI alloc] init];
    }
    return self;
}

- (void)loadCouponCountSuccess:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    [self.couponAPI couponsCountWithUserID:[VPUserManager sharedInstance].xx_userinfoID success:^(NSDictionary *responseDict) {
        success(responseDict[@"body"]);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


@end
