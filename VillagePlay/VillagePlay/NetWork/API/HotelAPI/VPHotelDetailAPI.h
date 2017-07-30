//
//  VPHotelDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPHotelDetailAPI : VPAPI


/**
 民宿详情

 @param params 民宿详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**

 获取房间列表
 @param params 房间信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelRoomListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 获取民宿设施

 @param params 民宿设施信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelFacilityListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 民宿提交更新价格

 @param params 更新价格提交信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelPriceParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 民宿信息提交

 @param params <#params description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)hotelUpOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 取消规则

 @param params 取消规则信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelRuleParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
