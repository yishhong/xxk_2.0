//
//  VPTravelDetailNameView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelDetailNameView.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActiveDetailModel.h"

@implementation VPTravelDetailNameView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPTitleColor];
    self.priceLabel.textColor =[UIColor VPRedColor];
}


- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    VPActiveDetailModel * activeDetailModel =cellModel.dataSource;
    self.nameLabel.text =activeDetailModel.title;
    self.priceLabel.text =activeDetailModel.costs;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
