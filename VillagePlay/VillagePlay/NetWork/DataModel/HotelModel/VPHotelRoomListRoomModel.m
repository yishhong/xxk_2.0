//
//  VPHotelRoomListRoom.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelRoomListRoomModel.h"

@implementation VPHotelRoomListRoomModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"infrastructure" : [VPFacilityListModel class],
             @"imgUrlArray" : [VPImgListModel class]
             };
}

@end
