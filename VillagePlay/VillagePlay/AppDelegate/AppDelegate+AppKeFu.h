//
//  AppDelegate+AppKeFu.h
//  VillagePlay
//
//  Created by Apricot on 16/11/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppKeFu)

/**
 *  登录App客服
 */
- (void)loginAppKeFu;
/**
 *  登出App客服
 */
- (void)logoutAppKeFu;

/**
 *  注册App客服通知
 *
 *  @param deviceToken <#deviceToken description#>
 */
- (void)appKeFuDeviceToken:(NSData *)deviceToken;
@end
