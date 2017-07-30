//
//  VPTravelSelectCouponTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelSelectCouponTableViewCell.h"
#import "UIColor+HUE.h"

@implementation VPTravelSelectCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor =[UIColor VPContentColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
