//
//  VPCityListTitleCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCityListTitleCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
@implementation VPCityListTitleCell

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
