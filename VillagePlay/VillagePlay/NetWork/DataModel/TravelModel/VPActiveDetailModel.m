//
//  VPActiveDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPActiveDetailModel.h"

@implementation VPActiveDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"lstActivityDate":[VPActivityDateModel class],
             @"lstActivityGoods":[VPActivityGoodsModel class],
             @"commentary":[VPCommentaryModel class]};
}

@end
