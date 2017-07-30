//
//  VPPlayListModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayListModel.h"

@implementation VPPlayListModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{
             @"items":[VPPlayDetailModel class],
             };
}
@end
