//
//  VPHotelOrderDetailController.hController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"

typedef void(^VPHotelOrderDetailControllerBlock)();

@interface VPHotelOrderDetailController : VPBaseViewController

+ (instancetype)instantiation;

@property (strong, nonatomic) NSString * orderNum;

@property (strong, nonatomic) VPHotelOrderDetailControllerBlock tappBlock;

@end
