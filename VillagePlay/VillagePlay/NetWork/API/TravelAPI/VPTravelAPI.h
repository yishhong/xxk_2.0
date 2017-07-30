//
//  VPTravelAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTravelAPI : VPAPI


/**
 旅游列表

 @param params 旅游列表信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 旅游顶部Tags

 @param params tags信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelTagsParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 旅游微信支付

 @param params 支付信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelPaymentParams:(NSDictionary*)params urlstring:(NSString *)urlstring success:(Success)success failure:(Failure)failure;

/**
 旅游支付宝支付

 @param params 支付信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelAlipayParams:(NSDictionary *)params urlstring:(NSString *)urlstring success:(Success)success failure:(Failure)failure;

@end
