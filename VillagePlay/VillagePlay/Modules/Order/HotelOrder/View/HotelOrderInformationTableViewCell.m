//
//  HotelOrderInformationTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelOrderInformationTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "VPHotelOrderDetailModel.h"
#import "NSString+DateString.h"
#import "QRCodeGenerator.h"

@implementation HotelOrderInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.checkPeopleNumberLabel.textColor=[UIColor VPDetailColor];
    self.checkDayNumberLabel.textColor= [UIColor VPDetailColor];
    self.checkDateLabel.textColor=[UIColor VPDetailColor];
    self.CheckOutDateLabel.textColor=[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    VPHotelOrderDetailModel *hotelOrderDetailModel =cellModel.dataSource;
    self.checkPeopleNumberLabel.text =[NSString stringWithFormat:@"入住人数:%ld人",hotelOrderDetailModel.checkPersonNum];
    NSString * dayNum =[NSString dateTimeStartTime:hotelOrderDetailModel.enterDataTime endTime:hotelOrderDetailModel.outDataTime];
    self.checkDayNumberLabel.text =[NSString stringWithFormat:@"入住天数:%@天",dayNum];
    self.checkDateLabel.text =[NSString stringWithFormat:@"入住时间%@",hotelOrderDetailModel.enterDataTime];
    self.CheckOutDateLabel.text =[NSString stringWithFormat:@"离店时间%@",hotelOrderDetailModel.outDataTime];
    if (hotelOrderDetailModel.orderState==3) {
        
        self.iconImageView.image =[QRCodeGenerator qrImageForString:hotelOrderDetailModel.orderNum imageSize:180];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
