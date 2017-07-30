//
//  VPTravelOrderAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTravelOrderAPI : VPAPI

/**
 我的旅游订单

 @param params 旅游订单信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
