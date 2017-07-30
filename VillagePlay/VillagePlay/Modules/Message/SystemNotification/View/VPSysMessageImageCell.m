//
//  VPSysMessageImageCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSysMessageImageCell.h"
#import "XXCellModel.h"
#import "VPSysMessageModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIImageView+VPWebImage.h"

@implementation VPSysMessageImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPSysMessageModel *sysMessageModel = cellModel.dataSource;
    [self.messageImage xx_setImageWithURLStr:sysMessageModel.imgUrl placeholder:[UIImage imageNamed:@"vp_vickersList_Image"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
