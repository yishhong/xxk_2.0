//
//  VillageImageTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VillageImageTableViewCell.h"
#import "UIImageView+VPWebImage.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VillageImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.villageImageView.layer.masksToBounds = YES;
    self.selectionStyle =UITableViewCellSelectionStyleNone;
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    NSString * urlString =cellModel.dataSource;
    [self.villageImageView xx_setImageWithURLStr:urlString placeholder:[UIImage imageNamed:@"vp_destination_playList_Iamge"]];
}

@end
