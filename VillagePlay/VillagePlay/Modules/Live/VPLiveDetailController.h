//
//  VPLiveDetailController.hController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPLiveInfoModel.h"

@interface VPLiveDetailController : VPBaseViewController

+ (instancetype)instantiation;


/**
 直播model
 */
@property (nonatomic, strong) VPLiveInfoModel * liveInfoModel;

@end
