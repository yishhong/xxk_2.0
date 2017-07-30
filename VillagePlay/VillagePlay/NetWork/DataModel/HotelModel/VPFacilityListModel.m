//
//  VPFacilityListModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPFacilityListModel.h"

@implementation VPFacilityListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id" : @"facilityID",
             @"typeid" : @"facilityTypeid"};
}

@end
