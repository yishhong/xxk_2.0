//
//  VPWantCommentController.hController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"
@interface VPWantCommentController : VPBaseViewController

+ (instancetype)instantiation;


/**
 渠道
 */
@property (nonatomic, assign) VPChannelType channelType;

/**
 对应的ID
 */
@property (nonatomic, assign) NSInteger objeID;

@end
