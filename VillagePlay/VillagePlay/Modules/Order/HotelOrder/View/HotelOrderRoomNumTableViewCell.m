//
//  HotelOrderRoomNumTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelOrderRoomNumTableViewCell.h"
#import "VPHotelOrderListModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "NSString+DateString.h"

@implementation HotelOrderRoomNumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.roomNumLabel.textColor =[UIColor VPTitleColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    VPHotelOrderListModel *hotelOrderListModel =cellModel.dataSource;
    NSString * dayNum =[NSString dateTimeStartTime:hotelOrderListModel.enterDataTime endTime:hotelOrderListModel.outDataTime];
    self.roomNumLabel.text =[NSString stringWithFormat:@"%@,定%@间 住%@晚",hotelOrderListModel.name,hotelOrderListModel.roomNum,dayNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
