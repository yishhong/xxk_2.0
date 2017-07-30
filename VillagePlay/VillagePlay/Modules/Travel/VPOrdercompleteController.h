//
//  VPOrdercompleteController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"

@interface VPOrdercompleteController : VPBaseViewController

+ (instancetype)instantiation;

@property(assign, nonatomic) double price;

@property(strong, nonatomic) NSString * paymethod;

@property (assign, nonatomic) VPChannelType channelType;

@end
