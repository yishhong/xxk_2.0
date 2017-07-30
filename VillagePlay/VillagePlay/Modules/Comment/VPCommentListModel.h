//
//  VPCommentListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XXCellModel.h"
#import "CommentDetaileEnum.h"

@interface VPCommentListModel : NSObject
/**
 评论列表

 @param VillageID 评论当前页ID
 @param commendType 评论类型
 @param isFirstLoading 是否下拉刷新
 @param success 成功回调
 @param failure 失败回调
 */
- (void)commentListVillageID:(NSString *)VillageID commendType:(VPChannelType)commendType IsFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

/**
 *  返回cell数目
 *
 *  @return cell数量
 */
- (NSInteger)numberOfRows;

/**
 *  获取指定行的cell
 *
 *  @param indexPath cell的坐标
 *
 *  @return 返回指定行的cellModel
 */
- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
