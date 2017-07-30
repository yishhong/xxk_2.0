//
//  VPOrderCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPOrderCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.orderIcon.layer.cornerRadius = 20;
    self.orderIcon.layer.masksToBounds = YES;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *info = cellModel.dataSource;
    self.orderIcon.image = [UIImage imageNamed:info[@"icon"]];
    self.lb_title.text = info[@"title"];
    if(cellModel.location == CellLocationEnd){
        self.lineView.hidden = YES;
    }else{
        self.lineView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
