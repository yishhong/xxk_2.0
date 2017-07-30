//
//  VPLiveImageTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveImageTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "VPLiveDetailModel.h"
#import "UIImageView+VPWebImage.h"
#import "XXCellModel.h"

@implementation VPLiveImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    NSString *urlString =cellModel.dataSource;
    [self.contentImageView xx_setImageWithURLStr:urlString placeholder:[UIImage imageNamed:@"vp_topic_Image"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
