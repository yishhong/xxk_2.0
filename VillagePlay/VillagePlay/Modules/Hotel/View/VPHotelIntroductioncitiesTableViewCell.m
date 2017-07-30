//
//  VPHotelFacitiesTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelIntroductioncitiesTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPHotelIntroductioncitiesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lb_detail.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSString * detailString =cellModel.dataSource;
    self.lb_detail.text =detailString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
