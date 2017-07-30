//
//  VPSpaceCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSpaceCell.h"
#import "UIColor+HUE.h"
@implementation VPSpaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor controllerBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
