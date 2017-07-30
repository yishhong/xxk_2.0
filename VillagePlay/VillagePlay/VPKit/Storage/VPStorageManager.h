//
//  VPStorageManager.h
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPUserInfoModel.h"
#import "VPBannerInfoModel.h"

@interface VPStorageManager : NSObject

#pragma mark - 登录模块

/**
 保存登录信息

 @param loginInfo 登录信息
 */
+ (void)saveLoginInfo:(NSDictionary *)loginInfo;

/**
 获取本地的登录信息

 @return 登录的用户信息
 */
+ (NSDictionary *)loadLoginInfo;

/**
 删除登录信息
 */
+ (void)deleteLoginInfo;

#pragma mark - User模块
/**
 *  存储用户信息
 *
 *  @param userInfo 用户信息
 */
+ (void)saveUserInfo:(VPUserInfoModel *)userInfo;

/**
 *  获取本地的用户信息
 *
 *  @return 用户信息
 */
+ (VPUserInfoModel *)loadUserInfo;

/**
 *  删除用户信息
 */
+ (void)deleteUserInfo;

#pragma mark - 授权Token模块
/**
 *  存储授权Token
 *
 *  @param authorization 授权Token信息
 */
+(void)saveAuthorization:(NSDictionary *)authorization;

/**
 *  加载本地的授权Token
 *
 *  @return 返回本地的授权信息
 */
+ (NSDictionary *)loadAuthorization;

/**
 *  删除授权Token信息
 */
+ (void)deleteAuthorization;

#pragma mark - 收藏模块

/**
 保存收藏记录

 @param collectionRecord 收藏记录数据
 @param type 收藏的类型
 */
+ (void)saveCollectionRecord:(NSDictionary *)collectionRecord type:(NSString *)type;

/**
 加载收藏记录数据

 @param type 收藏类型
 @return 返回指定类型的收藏记录
 */
+ (NSDictionary *)loadCollectionRecordWithType:(NSString *)type;

/**
 删除指定类型的收藏记录

 @param type 收藏类型
 */
+ (void)deleteCollectionRecordWithType:(NSString *)type;


/**
 保存启动的广告图

 @param StartPageInfo 启动广告图信息
 */
+ (void)saveStartPageInfo:(VPBannerInfoModel *)startPageInfo;

/**
 加载启动广告图信息

 @return 返回启动广告图信息
 */
+ (VPBannerInfoModel *)loadStartPageInfo;

/**
 删除启动的广告图
 */
+ (void)deleteStartPageInfo;


/**
 保存选中的地址

 @param cityDict 选中的城市字典
 */
+ (void)saveSelectCityDict:(NSDictionary *)cityDict;

/**
 加载选中的城市字典

 @return 返回选中的城市字典
 */
+ (NSDictionary *)loadCityDict;

/**
 删除选中的城市字典
 */
+ (void)deleteCityDict;

/**
 *  存储搜索记录
 *
 *  @param searchRecord 搜索记录
 */
+ (void)saveSearchRecord:(NSString *)searchRecord;

/**
 *  获取所有的搜索记录
 *
 *  @return 所有的搜索记录
 */
+ (NSArray *)loadSearchRecord;

/**
 *  删除搜索记录
 */
+ (void)deleteSearchRecord;

@end
