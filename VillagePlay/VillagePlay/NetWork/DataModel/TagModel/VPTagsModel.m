//
//  VPTagsModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTagsModel.h"

@implementation VPTagsModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"tags":[VPTagModel class]};
}

@end
