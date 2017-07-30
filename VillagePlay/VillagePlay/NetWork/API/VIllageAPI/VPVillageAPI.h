//
//  VPVillageAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPVillageAPI : VPAPI


/**
 乡村列表

 @param params 乡村列表信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)villageListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 乡村详情

 @param params 详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)villageDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 乡村tag列表

 @param params tag列表信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)villageTagListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
