//
//  VPSettingSwitchCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSettingSwitchCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VPSettingSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.switchButton addTarget:self action:@selector(switchValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchValue:(UISwitch *)switchButton{
    [self xx_cellClickAtView:switchButton data:@(switchButton.on)];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *info = cellModel.dataSource;
    self.lb_title.text = info[@"title"];
    [self.switchButton setOn:[info[@"value"] boolValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
