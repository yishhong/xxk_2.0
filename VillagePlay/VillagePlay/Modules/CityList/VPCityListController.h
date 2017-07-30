//
//  VPCityListController.hController
//  VillagePlay
//
//  Created by Apricot on 16/11/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPLocationManager.h"

@interface VPCityListController : VPBaseViewController

+ (instancetype)instantiation;


/**
 那个模块的定位
 */
@property (nonatomic, assign) LocationCoordinateType locationType;

@end
