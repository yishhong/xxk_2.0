//
//  VPActivateCouponViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPActivateCouponViewModel.h"
#import "VPCouponAPI.h"
#import "VPUserManager.h"


@interface VPActivateCouponViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPCouponAPI *couponAPI;


@end

@implementation VPActivateCouponViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.couponAPI = [[VPCouponAPI alloc] init];
    }
    return self;
}



- (void)activateCouponSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSError *error = nil;
    if(self.couponCode.length<1){
        error = [NSError errorCode:1024 message:@"请输入正确的优惠券码！"];
    }
    if(error){
        failure(error);
        return;
    }
    [self.couponAPI activationCouponWithCouponCode:self.couponCode userID:[VPUserManager sharedInstance].xx_userinfoID success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
