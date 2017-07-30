//
//  VPBuyTiketExplainTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBuyTiketExplainTableViewCell.h"
#import "UIColor+HUE.h"


@implementation VPBuyTiketExplainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.textColor =[UIColor VPContentColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
