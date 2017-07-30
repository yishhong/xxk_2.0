//
//  VPSubmitTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSubmitTableViewCell.h"
#import "UIColor+HUE.h"

@implementation VPSubmitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPContentColor];
    self.detailLabel.textColor =[UIColor VPDetailColor];
    self.priceLabel.textColor =[UIColor VPDetailColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
