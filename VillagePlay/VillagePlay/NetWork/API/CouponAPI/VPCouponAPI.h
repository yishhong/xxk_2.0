//
//  VPCouponAPI.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPCouponAPI : VPAPI

/**
 获取订单的优惠券

 @param userID 用户ID
 @param price 价格
 @param type 类型
 @param success 成功回调
 @param failure 失败回调
 */
- (void)orderCouponsWithUserID:(NSString *)userID type:(NSInteger)type price:(float )price success:(Success)success failure:(Failure)failure;

/**
 获取各个优惠券的数量

 @param userID 用户ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)couponsCountWithUserID:(NSString *)userID success:(Success)success failure:(Failure)failure;

/**
 激活优惠券

 @param couponCode 优惠券Code
 @param userID 用户ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)activationCouponWithCouponCode:(NSString *)couponCode userID:(NSString *)userID success:(Success)success failure:(Failure)failure;

/**
 获取优惠券的列表

 @param userID 用户ID
 @param couponStatus 状态
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadCouponListWithUserID:(NSString *)userID status:(NSInteger)couponStatus success:(Success)success failure:(Failure)failure;

@end
