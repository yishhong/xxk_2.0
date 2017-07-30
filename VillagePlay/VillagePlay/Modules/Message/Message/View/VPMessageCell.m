//
//  VPMessageCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMessageCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIImageView+VPWebImage.h"

@implementation VPMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary * info= cellModel.dataSource;
    self.messageIcon.image = [UIImage imageNamed:info[@"icon"]];
    self.lb_title.text = info[@"title"];
    self.lb_notRead.text = info[@"value"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
