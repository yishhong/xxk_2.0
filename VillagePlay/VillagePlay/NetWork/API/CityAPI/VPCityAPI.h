//
//  VPCityAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPCityAPI : VPAPI

/**
 *  获取开通城市列表
 *
 *  @param params  参数
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)loadCityListWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 获取指定模块的开通城市列表

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadRealCityListWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
