//
//  VillageLookMoreCommentTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VillageLookMoreCommentTableViewCell.h"
#import "UIColor+HUE.h"

@implementation VillageLookMoreCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lookMoreLabel.textColor =[UIColor VPDetailColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
