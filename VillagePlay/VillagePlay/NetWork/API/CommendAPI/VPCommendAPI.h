//
//  VPCommendAPI.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPCommendAPI : VPAPI

/**
 添加评论

 @param params 添加评论的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)addCommendWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 获取评论列表

 @param params 获取评论列表参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadCommendListWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 获取评论我的数量

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadCommentMessageCountWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 获取评论我的列表

 @param params 获取评论我的列表
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadUserCommendListWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
 删除评论

 @param commendID 评论ID
 @param userID 用户ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)deleteCommendWithCommendID:(NSString *)commendID userID:(NSString *)userID success:(Success)success failure:(Failure)failure;

@end
