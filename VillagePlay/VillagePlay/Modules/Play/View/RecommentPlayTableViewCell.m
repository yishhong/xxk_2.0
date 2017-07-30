//
//  RecommentPlayTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "RecommentPlayTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "VPPlayListModel.h"
#import "UITableViewCell+DataSource.h"

@implementation RecommentPlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.recommentTitleLabel.textColor =[UIColor VPContentColor];
    self.addressLabel.textColor =[UIColor navigationTintColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPPlayListModel * playListModel =cellModel.dataSource;
    self.recommentTitleLabel.text =playListModel.title;
    self.addressLabel.text =playListModel.lineName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
