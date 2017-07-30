//
//  VPRecommendVillageCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPVillageView.h"

@interface VPRecommendVillageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet VPVillageView *leftView;
@property (strong, nonatomic) IBOutlet VPVillageView *rightView;
@end
