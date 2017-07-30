//
//  VPTravelController.h
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPLocationManager.h"
@interface VPTravelController : VPBaseViewController

+ (instancetype)instantiation;

@property (strong, nonatomic)NSString * tag;

@property (strong, nonatomic)NSString * city;

@property (strong, nonatomic)NSString * location;

@property (strong, nonatomic)NSString * sortType;

@property (strong, nonatomic)NSString * provinceID;

@property (assign, nonatomic) LocationCoordinateType locationType;

@end
