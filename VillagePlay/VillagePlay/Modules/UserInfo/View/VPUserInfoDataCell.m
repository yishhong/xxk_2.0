//
//  VPUserInfoDataCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserInfoDataCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPUserInfoModel.h"

@interface VPUserInfoDataCell ()<UITextFieldDelegate>
@property (nonatomic, strong)VPUserInfoModel *userModel;
@property (nonatomic, strong)NSDictionary *info;
@end

@implementation VPUserInfoDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.info = cellModel.dataSource;
    self.userModel = self.info[@"value"];
    self.lb_title.text = self.info[@"title"];
    self.tf_value.delegate = self;
    self.tf_value.placeholder = self.info[@"placeholder"];
    self.tf_value.text = [self.userModel valueForKey:self.info[@"key"]];
    if(cellModel.action!=nil){
        self.tf_value.enabled = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.userModel setValue:textField.text.length>1?textField.text:@"" forKey:self.info[@"key"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
