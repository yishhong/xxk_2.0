//
//  VPRoomDescriptionTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRoomDescriptionTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "VPHotelRoomListRoomModel.h"

@implementation VPRoomDescriptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lb_RoomArea.textColor =[UIColor VPDetailColor];
    self.lb_BedNumber.textColor =[UIColor VPDetailColor];
    self.lb_RoomBedInformation.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    VPHotelRoomListRoomModel *hotelRoomListRoomModel =cellModel.dataSource;
    self.lb_RoomArea.text =[NSString stringWithFormat:@"房间面积:%@m²",hotelRoomListRoomModel.area];
    self.lb_BedNumber.text =[NSString stringWithFormat:@"床的数量:%@",hotelRoomListRoomModel.bedNum];
    self.lb_RoomBedInformation.text =[NSString stringWithFormat:@"房床信息:%@",hotelRoomListRoomModel.bed];
}



@end
