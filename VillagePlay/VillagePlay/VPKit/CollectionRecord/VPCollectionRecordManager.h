//
//  VPCollectionRecordManager.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentDetaileEnum.h"


@interface VPCollectionRecordManager : NSObject

/*
 查看是否收藏 -> 类型+Key 返回BOOL
 */


/**
 是否收藏

 @param type 收藏的类型
 @param key 收藏model的唯一ID
 @return 返回 YES已收藏 NO未收藏
 */
- (BOOL)isCollectionWithType:(VPChannelType)type key:(NSString *)key;

/*
 保存 ->  类型+Model+key -> 添加Model到对应的列表中
 */

/**
 添加收藏

 @param type 收藏的类型
 @param key 收藏model的唯一ID
 @param model 收藏的Model
 @param block 添加收藏事件的回调
 */
- (void)addCollectionRecordWithType:(VPChannelType)type key:(NSString *)key model:(id)model block:(void(^)(NSError *error,BOOL isSucceed))block;

/*
 读取 -> type ->Model列表
 */


/**
 获取指定收藏类型的所有收藏数据

 @param type 收藏类型
 @return 返回指定类型的数据
 */
- (NSArray *)collectionRecordWithType:(VPChannelType)type;

/*
 删除 ->type+Key ——> 删除指定的Model
 */

/**
 删除指定的收藏记录

 @param type 收藏的类型
 @param key 收藏model的唯一ID
 @param block 删除收藏事件的回调
 */
- (void)removeCollectionRecordWithType:(VPChannelType)type key:(NSString *)key block:(void(^)(NSError *error,BOOL isSucceed))block;

@end
