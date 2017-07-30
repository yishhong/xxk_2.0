//
//  VPWantCommentViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"XXCellModel.h"
#import "CommentDetaileEnum.h"


@interface VPWantCommentViewModel : NSObject

/**
 渠道
 */
@property (nonatomic, assign) VPChannelType channelType;

/**
 对应的ID
 */
@property (nonatomic, assign) NSInteger objeID;


- (void)layerUI;
//-(void)wantCommentModel:(NSArray *)wantCommentModel;

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
 发布评论

 @param success 成功回调
 @param failure 失败回调
 */
- (void)submitCommentSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;


@end
