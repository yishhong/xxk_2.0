//
//  VPUserAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPUserAPI : VPAPI

/**
 获取用户信息

 @param userId 用户ID
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)loadUserInfoWithUserId:(NSString *)userId success:(Success)success failure:(Failure)failure;


/**
 更新用户信息

 @param params 用户信息
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)updateUserInfoWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
