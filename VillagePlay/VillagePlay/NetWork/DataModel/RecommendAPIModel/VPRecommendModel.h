//
//  VPRecommendModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPBannerInfoModel.h"
#import "VPTopicListModel.h"
#import "VPActiveModel.h"
#import "VPLiveInfoModel.h"
#import "VPVillageModel.h"
#import "VPMagazineModel.h"

@interface VPRecommendModel : VPBaseModel

/**
 banner
 */
@property (nonatomic, strong) NSArray <VPBannerInfoModel *> * banner;

/**
 乡村
 */
@property (nonatomic, strong) NSArray <VPVillageModel *>* hotVillage;

/**
 旅游
 */
@property (nonatomic, strong) NSArray <VPActiveModel *> * hotActive;

/**
 专题
 */
@property (nonatomic, strong) NSArray <VPTopicListModel *> * hotProject;

/**
 直播
 */
@property (nonatomic, strong) NSArray <VPLiveInfoModel *> * liveList;

/**
 微刊
 */
@property (nonatomic, strong) NSArray <VPMagazineModel *> * weikan;

@end
