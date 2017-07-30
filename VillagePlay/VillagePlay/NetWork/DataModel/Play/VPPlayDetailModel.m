//
//  VPPlayDetailModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayDetailModel.h"

@implementation VPPlayDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{
             @"products":[VPPlayProductModel class],
             };
}

@end
