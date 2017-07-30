//
//  VPTicktDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTicktDetailAPI : VPAPI

/**
 门票详情
 
 @param params 门票详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


@end
