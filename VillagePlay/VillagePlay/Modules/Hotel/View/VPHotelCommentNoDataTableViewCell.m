//
//  VPHotelCommentNoDataTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelCommentNoDataTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"

@implementation VPHotelCommentNoDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentLabel.textColor =[UIColor VPDetailColor];
    self.commentButton.layer.masksToBounds =YES;
    self.commentButton.layer.cornerRadius =5.0f;
    self.commentButton.layer.borderColor =[UIColor navigationTintColor].CGColor;
    self.commentButton.layer.borderWidth =1.0f;
    [self.commentButton setTitleColor:[UIColor navigationTintColor] forState:UIControlStateNormal];
    self.contentView.backgroundColor =[UIColor controllerBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)commentAction:(UIButton *)sender {
    
    sender.tag =58;
    [self xx_cellClickAtView:sender];
}

@end
