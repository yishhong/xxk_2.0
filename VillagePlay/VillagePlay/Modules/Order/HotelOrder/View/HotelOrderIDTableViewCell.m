//
//  HotelOrderIDTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelOrderIDTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation HotelOrderIDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.orderStatusLabel.textColor =[UIColor orderColor];
    self.jupmImageView.hidden =YES;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    self.orderIDLabel.text =cellInfo[@"orderNum"];
    self.orderStatusLabel.text =cellInfo[@"orderState"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
