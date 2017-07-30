//
//  HBAuthorizationAPI.h
//  HotelBusiness
//
//  Created by Apricot on 16/9/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMAPIProxy.h"

@interface VPAuthorizationAPI : QMAPIProxy
/**
 *  客户端模式的获取Token
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)authorizationClientTokenSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 账号密码模式获取Token

 @param success 成功回调
 @param failure 失败回调
 */
- (void)authorizationPasswordTokenSuccess:(void (^)())success failure:(void (^)(NSError *))failure;
@end
