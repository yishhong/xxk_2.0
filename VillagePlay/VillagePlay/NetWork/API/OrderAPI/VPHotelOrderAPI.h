//
//  VPHotelAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPHotelOrderAPI : VPAPI

/**
 民宿订单列表

 @param params 民宿订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 民宿退款详情
 
 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 民宿获取订单状态
 
 @param params 民宿订单状态信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelOrderStateParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 旅游退款详情

 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 门票退款详情

 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
