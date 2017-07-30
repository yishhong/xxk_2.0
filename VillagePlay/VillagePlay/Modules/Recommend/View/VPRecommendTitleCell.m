//
//  VPRecommendTitleCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendTitleCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPRecommendTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *titleDict = cellModel.dataSource;
    self.lb_title.text = titleDict[@"title"];
    self.lb_subTitle.text = titleDict[@"subTitle"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
