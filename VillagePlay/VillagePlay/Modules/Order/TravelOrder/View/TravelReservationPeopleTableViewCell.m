//
//  TravelReservationPeopleTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelReservationPeopleTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "QRCodeGenerator.h"

@implementation TravelReservationPeopleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.reservationPeopleLabel.textColor =[UIColor VPContentColor];
    self.nameLabel.textColor =[UIColor VPDetailColor];
    self.telephoneLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    self.reservationImageView.image =[UIImage imageNamed:cellInfo[@"image"]];
    self.nameLabel.text =cellInfo[@"name"];
    self.reservationPeopleLabel.text =cellInfo[@"title"];
    self.telephoneLabel.text =cellInfo[@"phoneNumber"];
    if ([cellInfo[@"orderState"] integerValue]==1) {
        self.BarcodeImageView.image =[QRCodeGenerator qrImageForString:cellInfo[@"order"] imageSize:180];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
