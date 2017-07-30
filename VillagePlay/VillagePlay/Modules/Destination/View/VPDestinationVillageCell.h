//
//  VPDestinationVillageCell.h
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPDestinationVillageView.h"
@interface VPDestinationVillageCell : UITableViewCell


/**
 右边的视图
 */
@property (strong, nonatomic) IBOutlet VPDestinationVillageView *rightView;

/**
 左边的视图
 */
@property (strong, nonatomic) IBOutlet VPDestinationVillageView *leftView;

/**
 中间的视图
 */
@property (strong, nonatomic) IBOutlet VPDestinationVillageView *centerView;

@end
