//
//  VPLoginAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPLoginAPI : VPAPI

/**
 *  账号登录
 *
 *  @param params  登录信息
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)loginAccountWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 *  其他账号登录
 *
 *  @param params  登录信息
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)loginOthertWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 *  注册用户
 *
 *  @param params  用户信息
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)registerUserWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 *  发送验证码
 *
 *  @param params  用户信息
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)shortMessageParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 *  修改密码
 *
 *  @param params  用户信息
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)modifyPassWordParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
