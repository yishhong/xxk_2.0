//
//  TravelPayWayTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelPayWayTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelOrderDetailModel.h"

@implementation TravelPayWayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.payWayLabel.textColor =[UIColor VPContentColor];
    self.preferencePriceLabel.textColor =[UIColor orderColor];
    self.payPriceLabel.textColor =[UIColor orderColor];
    self.payTimeLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    self.payWayLabel.text =cellInfo[@"payWay"];
    self.preferencePriceLabel.text =cellInfo[@"couponPrice"];
    self.payPriceLabel.text =cellInfo[@"price"];
    self.payTimeLabel.text =cellInfo[@"payTime"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
