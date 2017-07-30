//
//  TopicDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicDetailModel.h"

@implementation VPTopicDetailModel


+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"projectVillage":[TopicVillageModel class],
             @"lstActivity":[VPActiveModel class],
             @"commentary":[VPCommentaryModel class]};
}

@end
