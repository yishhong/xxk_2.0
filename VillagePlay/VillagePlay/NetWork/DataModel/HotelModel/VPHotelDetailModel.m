//
//  VPHotelDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelDetailModel.h"

@implementation VPHotelDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"facilityList" : [VPFacilityListModel class],
             @"imgList" : [VPImgListModel class]
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id" : @"bodyIdentifier"};
}


@end
