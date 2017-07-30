//
//  VPHotelInformtionTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelInformtionTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelRoomListRoomModel.h"

@implementation VPHotelInformtionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor =[UIColor controllerBackgroundColor];
    self.CheckDateLabel.textColor =[UIColor VPDetailColor];
    self.outDateLabel.textColor =[UIColor VPDetailColor];
    self.facilityLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    VPHotelRoomListRoomModel *hotelRoomListRoomModel =cellInfo[@"roomListRoomModel"];
    self.CheckDateLabel.text =[NSString stringWithFormat:@"入住时间:%@",cellInfo[@"checkTime"]];
    self.outDateLabel.text =[NSString stringWithFormat:@"离店时间:%@",cellInfo[@"outTime"]];
    self.nameLabel.text =hotelRoomListRoomModel.name;
    self.roomTypeLabel.text =hotelRoomListRoomModel.bed;
    NSMutableArray *facilityArray =[NSMutableArray array];
    for (VPFacilityListModel *facilityListModel in hotelRoomListRoomModel.infrastructure) {
        [facilityArray addObject:facilityListModel.title];
    }
    self.facilityLabel.text =[facilityArray componentsJoinedByString:@" "];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
