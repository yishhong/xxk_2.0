//
//  VPPhoneNumberTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPhoneNumberTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelSubmitModel.h"
#import "UIColor+HUE.h"

@interface VPPhoneNumberTableViewCell()

@property (strong, nonatomic)NSDictionary *info;

@end

@implementation VPPhoneNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.jupmImageView.hidden =YES;
    self.nameLabel.textColor =[UIColor VPDetailColor];

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    self.info =cellModel.dataSource;
    self.nameLabel.text=self.info[@"title"];
    self.phoneNumberTextField.placeholder =self.info[@"placeholder"];
    VPHotelSubmitModel *hotelSubmitModel =self.info[@"value"];
    self.phoneNumberTextField.text =[hotelSubmitModel valueForKey:self.info[@"key"]];
    self.phoneNumberTextField.delegate =self;
    self.phoneNumberTextField.keyboardType =cellModel.keyboardType;
    if(cellModel.action!=nil){
        self.phoneNumberTextField.enabled = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    VPHotelSubmitModel *hotelSubmitModel =self.info[@"value"];
    [hotelSubmitModel setValue:textField.text forKey:self.info[@"key"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
