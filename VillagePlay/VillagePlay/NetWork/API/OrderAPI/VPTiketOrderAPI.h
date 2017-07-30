//
//  VPTiketOrderAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTiketOrderAPI : VPAPI

/**
 门票订单列表

 @param params 门票列表信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)trketOrderListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 门票订单详情

 @param params 订单详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)trketOrderDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 取消订单

 @param params 订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)tiketCancelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 申请退款

 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)tiketRefundOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
