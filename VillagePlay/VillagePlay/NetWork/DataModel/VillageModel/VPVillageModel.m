//
//  VPVillageModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVillageModel.h"
#import "VPLocationManager.h"

@implementation VPVillageModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"tags" : [VPTagModel class]
             };
}

- (NSString *)distance{
    NSString *distance = @"";
    if([VPLocationManager sharedManager].isLocation){
        distance = [QMMapFuntion distanseBetweenWithStartCoord:[VPLocationManager sharedManager].location endCoord:[QMMapFuntion transformCoordinate:self.location]];
    }else{
        distance = @"未知";
    }
    return distance;
}

@end
