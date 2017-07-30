//
//  VPMineListCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMineListCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
@implementation VPMineListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *info = cellModel.dataSource;
    self.icon.image = [UIImage imageNamed:info[@"icon"]];
    self.lb_title.text = info[@"title"];
    self.lb_title.textColor = [UIColor navigationTitleColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
