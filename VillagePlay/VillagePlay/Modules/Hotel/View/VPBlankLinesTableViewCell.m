//
//  VPBlankLinesTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBlankLinesTableViewCell.h"
#import "UIColor+HUE.h"

@implementation VPBlankLinesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor =[UIColor controllerBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
