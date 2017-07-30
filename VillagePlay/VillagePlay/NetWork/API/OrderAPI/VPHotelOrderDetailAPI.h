//
//  VPHotelOrderDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPHotelOrderDetailAPI : VPAPI


/**
 民宿订单详情

 @param params 订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelOrderDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 民宿退款订单详情

 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelOrderRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 取消订单
 @param params 取消订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelCancelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 删除订单

 @param params 删除订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelDeleteOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
