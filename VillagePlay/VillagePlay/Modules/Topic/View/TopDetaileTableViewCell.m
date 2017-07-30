//
//  TopDetaileTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TopDetaileTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "VPTopicDetailModel.h"
#import "XXCellModel.h"
#import "UIImageView+VPWebImage.h"

@implementation TopDetaileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.headImageView.layer.masksToBounds =YES;
    self.headImageView.layer.cornerRadius =25.0f;
    self.titleLabel.textColor =[UIColor VPContentColor];
    self.subTitleLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

     XXCellModel *cellModel=(XXCellModel *)entity;
     VPTopicDetailModel * topicDetailModel=cellModel.dataSource;
    [self.headImageView xx_setImageWithURLStr:topicDetailModel.photoUrl placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
    self.titleLabel.text =topicDetailModel.projectName;
    self.subTitleLabel.text =topicDetailModel.desc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
