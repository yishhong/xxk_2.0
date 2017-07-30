//
//  OrderTypeTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "OrderTypeTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation OrderTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPTitleColor];
    self.statusLabel.textColor =[UIColor orderColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    self.nameLabel.text =cellInfo[@"name"];
    self.statusLabel.text =cellInfo[@"orderState"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
