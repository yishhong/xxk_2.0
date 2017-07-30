//
//  VPTravelDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTravelDetailAPI : VPAPI


/**
 旅游详情

 @param params 旅游信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 旅游订单信息提交

 @param params 提交信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelOrderWritelParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
