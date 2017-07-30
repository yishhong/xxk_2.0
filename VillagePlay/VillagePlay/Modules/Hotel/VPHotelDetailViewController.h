//
//  VPHotelDetailViewController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"

@interface VPHotelDetailViewController : VPBaseViewController

@property(assign, nonatomic)NSInteger hid;

@property (strong, nonatomic) NSMutableDictionary * dateInfo;

+ (instancetype)instantiation;

@end
