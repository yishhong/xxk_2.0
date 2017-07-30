//
//  VPSearchController.hController
//  VillagePlay
//
//  Created by Apricot on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPSearchViewModel.h"
#import "VPLocationManager.h"
@interface VPSearchController : VPBaseViewController

+ (instancetype)instantiation;

@property (assign, nonatomic) SearchType searchType;

/**
 城市ID
 */
@property (copy, nonatomic) NSString * cityID;

@end
