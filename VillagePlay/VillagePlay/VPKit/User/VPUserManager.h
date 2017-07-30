//
//  VPUserManager.h
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPUserInfoModel.h"

@interface VPUserManager : NSObject

/**
 *  用于获取用户信息
 *
 *  @return <#return value description#>
 */
+(instancetype)sharedInstance;


/**
 保存登录信息

 @param loginInfo 登录账号信息（微信保存openID,账号体系保存手机号码）
 */

/**
 保存登录信息

 @param userName 为返回字典的KEY 保存登录的userName
 @param pwd 为返回字典的KEY 保存登录密码
 */
- (void)xx_saveLoginInfoWithUserName:(NSString *)userName pwd:(NSString *)pwd;

/**
 获取登录信息 KEY:1.->userName 2.->pwd

 @return 返回登录信息
 */
- (NSDictionary *)xx_loginInfo;

/**
 删除登录信息
 */
- (void)xx_deleteLoginInfo;

/**
 *  保存用户信息(只用于登录的处)
 *
 *  @param userInfo 用户信息
 */
- (void)xx_saveUserInfo:(VPUserInfoModel *)userInfo;

/**
 *  获取用户信息
 *
 *  @return 返回用户信息
 */
- (VPUserInfoModel *)xx_userInfo;

/**
 *  删除用户信息（用于退出时）
 */
- (void)xx_deleteUserInfo;

/**
 *  更新用户信息(用户编辑了信息修改时更新)
 *
 *  @param userInfo 最新的用户信息
 */
- (void)xx_updateUserInfo:(VPUserInfoModel *)userInfo;

/**
 *  返回用户ID
 *
 *  @return NSString
 */
-(NSString *)xx_userinfoID;


/**
 *  存储Token
 */
- (void)saveAuthorizationToken:(NSDictionary *)authorization;

/**
 *  获取授权Token
 *
 *  @return 返回授权的Token
 */
- (NSDictionary *)loadAuthorizationToken;
@end
