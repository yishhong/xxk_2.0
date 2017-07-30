//
//  VPHotelRoomListTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelRoomListTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "UIColor+HUE.h"

@implementation VPHotelRoomListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lb_bedType.textColor =[UIColor VPContentColor];
}
- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSString *bedTypeString =cellModel.dataSource;
    self.lb_bedType.text =bedTypeString;
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    sender.tag =-10;
    [self xx_cellClickAtView:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
