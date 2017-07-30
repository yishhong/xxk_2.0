//
//  VPRecommendLiveCell.h
//  VillagePlay
//
//  Created by Apricot on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VPLiveView.h"

@interface VPRecommendLiveCell : UITableViewCell
@property (strong, nonatomic) IBOutlet VPLiveView *leftView;
@property (strong, nonatomic) IBOutlet VPLiveView *rightView;

@end
