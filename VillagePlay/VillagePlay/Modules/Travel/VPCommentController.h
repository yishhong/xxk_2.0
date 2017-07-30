//
//  VPCommentController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPParentClassScrollController.h"
#import "CommentDetaileEnum.h"

@interface VPCommentController : VPParentClassScrollController

@property(assign, nonatomic) VPChannelType channelType;

+ (instancetype)instantiation;

@property(strong, nonatomic)NSString * villageID;

@end
