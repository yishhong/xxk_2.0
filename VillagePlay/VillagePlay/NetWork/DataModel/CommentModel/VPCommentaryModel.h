//
//  CommentaryModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//


#import "VPBaseModel.h"

@interface VPCommentaryModel : VPBaseModel

/**
 *  是否是大咖
 */
@property(nonatomic,assign) NSInteger  isMaster;


@property (nonatomic, copy) NSString *vid;
/**
 *  评论人id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  头像
 */
@property (nonatomic, copy) NSURL *avatar;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  星级
 */
@property (nonatomic, assign) NSInteger star;
/**
 *  评论内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  评论时间
 */
@property (nonatomic, copy) NSString *dataTime;

/** 回复的人
 *
 */
@property (nonatomic, copy) NSString *beNickname;

/** 回复的人ID
 *
 */
@property (nonatomic, copy) NSString *beUserId;

/**
 小头像
 */
@property (nonatomic, copy) NSString *smallHeadPhoto;

/**
 图片数组
 */
@property (nonatomic ,strong) NSArray *imgs;




@end
