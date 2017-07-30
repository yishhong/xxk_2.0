//
//  VPMyCommentSourceCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMyCommentSourceCell.h"
#import "XXCellModel.h"
#import "VPMyCommendModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VPMyCommentSourceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPMyCommendModel *myCommendModel = cellModel.dataSource;
    self.lb_title.text = [NSString stringWithFormat:@"%@",myCommendModel.theme];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
