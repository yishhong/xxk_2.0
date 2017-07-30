//
//  VPSysMessageAPI.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPSysMessageAPI : VPAPI


/**
 获取用户系统通知

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSysMessageWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

///**
// 读取单条系统通知
//
// @param params 参数
// @param success 成功回调
// @param failure 失败回调
// */
//- (void)loadSingleSysMessageWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 获取未读消息数

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSysMessageCountWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
