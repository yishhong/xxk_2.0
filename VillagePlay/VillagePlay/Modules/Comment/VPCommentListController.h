//
//  VPCommentListController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"

@interface VPCommentListController : VPBaseViewController

@property (assign, nonatomic) VPChannelType channelType;

@property (strong, nonatomic) NSString * villageID;

+ (instancetype)instantiation;

@end
