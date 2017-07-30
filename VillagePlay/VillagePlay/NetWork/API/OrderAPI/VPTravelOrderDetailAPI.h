//
//  VPTravelOrderDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTravelOrderDetailAPI : VPAPI

/**
 旅游订单详情
 
 @param params 订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelOrderDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 旅游退款订单详情
 
 @param params 退款详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelOrderRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 申请退款

 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelRefundParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 取消订单

 @param params 订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelCancelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
