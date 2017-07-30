//
//  VPPlayAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPPlayAPI : VPAPI

/**
 玩法列表

 @param params 玩法信息
 @param success 成功回调
 @param failure 失败回调
 */
-(void)playListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 玩法详情

 @param params 玩法详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)playDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
