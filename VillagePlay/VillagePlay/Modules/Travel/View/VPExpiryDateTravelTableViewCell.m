//
//  VPExpiryDateTravelTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPExpiryDateTravelTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VPExpiryDateTravelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString * timeDate =cellModel.dataSource;
    [self.lb_timeLabel setTitle:timeDate forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
