//
//  VPBeautifulVillageController.hController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPLocationManager.h"

@interface VPBeautifulVillageController : VPBaseViewController

+ (instancetype)instantiation;

@property (assign, nonatomic) LocationCoordinateType locationType;


/**
 2为精选
 */
@property (assign, nonatomic) NSInteger type;

//@property (nonatomic, assign) BOOL isSelectAddress;

@end
