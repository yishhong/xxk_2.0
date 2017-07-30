//
//  VPRecommendModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendModel.h"

@implementation VPRecommendModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{
             @"banner" : [VPBannerInfoModel class],
             @"hotActive" : [VPActiveModel class],
             @"hotProject" : [VPTopicListModel class],
             @"liveList" : [VPLiveInfoModel class],
             @"hotVillage" : [VPVillageModel class],
             @"weikan" : [VPMagazineModel class],
             };
}


@end
