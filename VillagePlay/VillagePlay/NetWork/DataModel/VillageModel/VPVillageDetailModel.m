//
//  VPVillageDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVillageDetailModel.h"

@implementation VPVillageDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"tags" : [VPTagModel class],
             @"commentary" : [VPCommentaryModel class],
             @"images" : [VPVillageImagesModel class],
             @"lstSpecial":[VPLstSpecialModel class]
             };
}

@end
