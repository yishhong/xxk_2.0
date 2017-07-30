//
//  VPMoreCommentTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMoreCommentTableViewCell.h"
#import "UIColor+HUE.h"

@implementation VPMoreCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentNumber.textColor =[UIColor VPContentColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
