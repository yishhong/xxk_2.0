
//
//  TopicTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "VPTopicListModel.h"
#import "UIImageView+VPWebImage.h"
#import "XXCellModel.h"

@implementation TopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topicImageView.layer.cornerRadius = 2;
    self.belowView.layer.cornerRadius = 2;
    self.topicImageView.layer.masksToBounds = YES;
    self.belowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel * cellModel = entity;
    VPTopicListModel * topicListModel = cellModel.dataSource;
    [self.topicImageView xx_setImageWithURLStr:topicListModel.photoUrl placeholder:[UIImage imageNamed:@"vp_topic_Image"]];
    self.titleLabel.text = topicListModel.projectName;
    self.timeLbael.text =topicListModel.creatDateTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
