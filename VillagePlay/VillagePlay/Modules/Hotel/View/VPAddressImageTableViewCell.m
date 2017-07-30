//
//  VPAddressImageTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAddressImageTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "UIImageView+VPWebImage.h"
#import "XXCellModel.h"
#import "VPLocationManager.h"

#define W ([UIScreen mainScreen].bounds.size.width)

@implementation VPAddressImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressImageView.layer.cornerRadius=2.0f;
    self.addressImageView.layer.masksToBounds=YES;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString*lonString =cellModel.dataSource;
    NSString * location = lonString;
    
    NSString * urlString= [VPLocationManager loadMapImageWith:location size:CGSizeMake(W-24, 100)];

    [self.addressImageView xx_setImageWithURLStr:urlString placeholder:[UIImage imageNamed:@"vp_topic_Image"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
