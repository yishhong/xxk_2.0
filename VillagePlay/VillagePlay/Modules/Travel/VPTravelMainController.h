//
//  VPTravelMainController.hController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPLocationManager.h"

@interface VPTravelMainController : VPBaseViewController

+ (instancetype)instantiation;

@property (strong, nonatomic)NSString * location;

@property (strong, nonatomic)NSString * city;

@property (assign, nonatomic) LocationCoordinateType locationType;

@end
