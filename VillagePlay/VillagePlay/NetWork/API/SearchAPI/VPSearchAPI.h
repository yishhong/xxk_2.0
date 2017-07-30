//
//  VPSearchAPI.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPSearchAPI : VPAPI


/**
 搜索全部搜索数据

 @param key 搜索的关键字
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSearchAllWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 搜索村庄

 @param params 搜索的村庄参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)loadSearchVillageWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 搜索活动

 @param params 搜索活动的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSearchActiveWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 搜索民宿

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSearchHotelWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 搜索门票

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSearchTicketWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
