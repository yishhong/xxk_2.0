//
//  VPHotelController.h
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPLocationManager.h"

@interface VPHotelController : VPBaseViewController

+ (instancetype)instantiation;

@property (assign, nonatomic) LocationCoordinateType locationType;

@end
