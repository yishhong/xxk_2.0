//
//  VPSearchViewCleanCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewCleanCell.h"
#import "UIColor+HUE.h"
@interface VPSearchViewCleanCell ()
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation VPSearchViewCleanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.clearButton.layer.borderColor = [UIColor colorWithRed:0.9608 green:0.4 blue:0.1333 alpha:1.0].CGColor;
//    self.clearButton.layer.borderWidth = 0.5;
    self.clearButton.titleLabel.textColor = [UIColor navigationTintColor];
    self.clearButton.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
