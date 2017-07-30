//
//  VPHotelRoomNumTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelRoomNumTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelSubmitModel.h"
#import "UIColor+HUE.h"

@interface VPHotelRoomNumTableViewCell ()

@property (strong, nonatomic) NSDictionary * cellInfo;

@end

@implementation VPHotelRoomNumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.roomTitleLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    self.cellInfo =(NSDictionary *)cellModel.dataSource;
    self.roomTitleLabel.text =self.cellInfo[@"title"];
    VPHotelSubmitModel *hotelSubmitModel =self.cellInfo[@"value"];
    self.roomNumberLabel.text =[NSString stringWithFormat:@"%@间",[hotelSubmitModel valueForKey:self.cellInfo[@"key"]]];
}

@end
