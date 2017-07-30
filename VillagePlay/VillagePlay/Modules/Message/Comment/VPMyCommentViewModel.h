//
//  VPMyCommentViewModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
@interface VPMyCommentViewModel : NSObject

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

/**
 加载评论我的数据

 @param isFirst 是否首次加载
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadMyCommentMessageWithIsFirst:(BOOL)isFirst success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

@end
