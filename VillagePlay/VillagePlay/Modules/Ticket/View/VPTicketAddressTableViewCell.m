//
//  VPTicketAddressTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketAddressTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPTicketListModel.h"

@implementation VPTicketAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressLabel.textColor =[UIColor VPContentColor];
    self.distanceLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    VPTicketListModel * ticketListModel =cellInfo[@"name"];
    //距离
    self.distanceLabel.text =@"";
    self.addressLabel.text =ticketListModel.actAddress;
    self.iconImageView.image =[UIImage imageNamed:cellInfo[@"image"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
