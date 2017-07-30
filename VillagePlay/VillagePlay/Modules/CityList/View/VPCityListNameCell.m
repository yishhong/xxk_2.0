//
//  VPCityListNameCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCityListNameCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPOpenCityInfoModel.h"
#import "UIColor+HUE.h"

@implementation VPCityListNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectIcon.hidden = YES;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPOpenCityInfoModel * cityInfoModel = cellModel.dataSource;
    self.lb_title.text = cityInfoModel.cityName;
    if(cityInfoModel.isSelsct){
        self.lb_title.textColor = [UIColor navigationTintColor];
        self.selectIcon.hidden = NO;
    }else{
        self.lb_title.textColor = [UIColor blackTextColor];
        self.selectIcon.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
