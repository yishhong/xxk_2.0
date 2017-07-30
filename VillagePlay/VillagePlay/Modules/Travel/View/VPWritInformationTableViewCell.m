//
//  VPWritInformationTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWritInformationTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPTravilSubitInformationModel.h"

@interface VPWritInformationTableViewCell ()<UITextFieldDelegate>

@property (strong, nonatomic)NSDictionary * info;

@end

@implementation VPWritInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLbael.textColor =[UIColor VPContentColor];
    self.info =[NSDictionary dictionary];
    self.nameTextField.delegate = self;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    self.info =cellModel.dataSource;
    VPTravilSubitInformationModel *travilSubitInformationModel =self.info[@"value"];
    self.nameLbael.text =self.info[@"title"];
    self.nameTextField.placeholder =self.info[@"placeholder"];
    self.nameTextField.text =[travilSubitInformationModel valueForKey:self.info[@"key"]];
    self.nameTextField.keyboardType =cellModel.keyboardType;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    VPTravilSubitInformationModel *travilSubitInformationModel =self.info[@"value"];

    [travilSubitInformationModel setValue:textField.text forKey:self.info[@"key"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
