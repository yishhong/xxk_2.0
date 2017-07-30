//
//  VPSettingEventCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSettingEventCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VPSettingEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.lb_title.text = cellModel.dataSource;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
