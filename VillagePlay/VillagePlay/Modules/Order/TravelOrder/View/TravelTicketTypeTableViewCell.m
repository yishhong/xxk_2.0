//
//  TravelTicketTypeTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelTicketTypeTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPTravelSubitLstGoods.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation TravelTicketTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeLabel.textColor =[UIColor VPDetailColor];
    self.userTimeLabel.textColor =[UIColor VPDetailColor];
    self.buyNumberLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary  *goodsInfo =cellModel.dataSource;
    self.typeLabel.text =goodsInfo[@"goods"];
    self.userTimeLabel.text =goodsInfo[@"time"];
    self.buyNumberLabel.text =goodsInfo[@"number"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
