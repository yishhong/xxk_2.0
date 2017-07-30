//
//  VPaddMoreTiketListController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPActivityGoodsModel.h"

typedef void(^VPaddMoreTiketListControllerBlock)(VPActivityGoodsModel *activityGoodsModel,NSIndexPath * indexPath);

@interface VPaddMoreTiketListController : VPBaseViewController

+ (instancetype)instantiation;

@property (strong, nonatomic)VPaddMoreTiketListControllerBlock tappedBlock;

@property (strong, nonatomic)NSMutableArray * tiketArray;

@property (strong, nonatomic) NSIndexPath * indexPath;

@end
