//
//  VPCouponModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponModel.h"

@implementation VPCouponModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc" : @"description"
             };
}
@end
