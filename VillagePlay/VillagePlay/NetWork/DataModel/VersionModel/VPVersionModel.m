//
//  VPVersionModel.m
//  VillagePlay
//
//  Created by Apricot on 2017/1/14.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "VPVersionModel.h"

@implementation VPVersionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.state = 0;
        self.editionNum = 0;
        self.isForced = NO;
        
    }
    return self;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc" : @"description"
             };
}
@end
