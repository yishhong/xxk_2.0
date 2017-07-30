//
//  TravelWritRefundReasonTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelWritRefundReasonTableViewCell.h"

@implementation TravelWritRefundReasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textFieldName.delegate =self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if ([self.detegate respondsToSelector:@selector(refundReasonString:)]) {
        
        [self.detegate refundReasonString:textField.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
