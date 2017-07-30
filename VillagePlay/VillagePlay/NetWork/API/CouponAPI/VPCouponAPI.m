//
//  VPCouponAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponAPI.h"

@implementation VPCouponAPI

- (void)orderCouponsWithUserID:(NSString *)userID type:(NSInteger)type price:(float )price success:(Success)success failure:(Failure)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userID;
    params[@"type"] = @(type);
    params[@"price"] = @(price);
    [self sendGETAPI:@"api/Coupon/GetOrderCoupons" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)couponsCountWithUserID:(NSString *)userID success:(Success)success failure:(Failure)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userID;
    [self sendGETAPI:@"api/Coupon/GetMyCouponsCount" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)activationCouponWithCouponCode:(NSString *)couponCode userID:(NSString *)userID success:(Success)success failure:(Failure)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"couponCode"] = couponCode;
    params[@"userId"] = userID;
    [self sendPOSTAPI:@"api/Coupon/PostActivationCoupon" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadCouponListWithUserID:(NSString *)userID status:(NSInteger)couponStatus success:(Success)success failure:(Failure)failure{
    ///
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"couponStatus"] = @(couponStatus);
    params[@"userId"] = userID;
    [self sendGETAPI:@"api/Coupon/GetCoupons" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
