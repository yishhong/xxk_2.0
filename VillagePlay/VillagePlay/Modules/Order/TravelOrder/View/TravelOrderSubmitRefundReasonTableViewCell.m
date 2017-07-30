//
//  TravelOrderSubmitRefundReasonTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelOrderSubmitRefundReasonTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"

@implementation TravelOrderSubmitRefundReasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.submitButton.layer.masksToBounds =YES;
    self.submitButton.layer.cornerRadius =2.0f;
    [self.submitButton setBackgroundColor:[UIColor navigationTintColor]];
}
- (IBAction)submitAction:(id)sender {
    
    [self xx_cellClickAtView:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
