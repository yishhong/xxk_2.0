//
//  TopicRecommendTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TopicRecommendTableViewCell.h"
#import "UIColor+HUE.h"

@implementation TopicRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.recommentLabel.textColor =[UIColor VPContentColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
