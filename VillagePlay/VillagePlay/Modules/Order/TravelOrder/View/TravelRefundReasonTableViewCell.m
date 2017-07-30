//
//  TravelRefundReasonTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelRefundReasonTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation TravelRefundReasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * refundInfo =cellModel.dataSource;
    self.nameLabel.text =refundInfo[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
