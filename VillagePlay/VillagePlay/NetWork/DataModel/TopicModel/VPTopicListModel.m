//
//  VPTopicListModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicListModel.h"

@implementation VPTopicListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc" : @"description"
             };
}
@end
