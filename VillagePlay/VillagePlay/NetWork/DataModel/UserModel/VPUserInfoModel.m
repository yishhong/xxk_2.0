//
//  VPUserInfoModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserInfoModel.h"
#import "NSObject+YYModel.h"

@implementation VPUserInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNotice = YES;
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"photoUrls":[VPPersonalDyn class],
             @"userphotoModel":[VPUserphotoModel class]};
}

@end
