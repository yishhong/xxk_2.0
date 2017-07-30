//
//  VPRecommendMenuCell.h
//  VillagePlay
//
//  Created by Apricot on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendMenuView.h"


@interface VPRecommendMenuCell : UITableViewCell
@property (strong, nonatomic) IBOutlet RecommendMenuView *leftView;
@property (strong, nonatomic) IBOutlet RecommendMenuView *centreView;
@property (strong, nonatomic) IBOutlet RecommendMenuView *rightView;

@end
