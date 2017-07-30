//
//  VillageTitleTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VillageTitleTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VillageTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString * nameString =cellModel.dataSource;
    self.villageTitleLabel.text =nameString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
