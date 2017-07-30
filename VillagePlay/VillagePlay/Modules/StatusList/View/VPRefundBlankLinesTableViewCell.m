//
//  VPRefundBlankLinesTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRefundBlankLinesTableViewCell.h"
#import "UIColor+HUE.h"

@implementation VPRefundBlankLinesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor =[UIColor controllerBackgroundColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
