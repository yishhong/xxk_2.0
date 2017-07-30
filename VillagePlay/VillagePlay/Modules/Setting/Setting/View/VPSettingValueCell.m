//
//  VPSettingValueCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSettingValueCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"

@implementation VPSettingValueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_title.textColor = [UIColor blackTextColor];
}
- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *info = cellModel.dataSource;
    self.lb_title.text = info[@"title"];
    self.lb_value.text = info[@"value"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
