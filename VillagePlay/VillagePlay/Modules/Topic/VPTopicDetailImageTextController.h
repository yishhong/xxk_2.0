//
//  VPTopicDetailImageTextViewController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPParentClassScrollController.h"
#import "VPTopicDetailModel.h"

@interface VPTopicDetailImageTextController : VPParentClassScrollController

+ (instancetype)instantiation;

@property(strong, nonatomic) VPTopicDetailModel * topicDetailModel;

@end
