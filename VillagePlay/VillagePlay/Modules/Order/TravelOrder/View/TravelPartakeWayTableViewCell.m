//
//  TravelPartakeWayTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelPartakeWayTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation TravelPartakeWayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.partakeWayLabel.textColor =[UIColor VPContentColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    self.partakeWayLabel.text =cellInfo[@"address"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
