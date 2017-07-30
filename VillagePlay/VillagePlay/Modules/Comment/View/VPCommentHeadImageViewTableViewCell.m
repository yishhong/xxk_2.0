//
//  VPCommentHeadImageViewTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentHeadImageViewTableViewCell.h"
#import "UIColor+HUE.h"
#import "UIColor+HEX.h"
#import "UITableViewCell+DataSource.h"
#import "VPCommentaryModel.h"
#import "XXCellModel.h"
#import "UIImageView+VPWebImage.h"

@implementation VPCommentHeadImageViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius =20;
    self.headImageView.layer.masksToBounds =YES;
    self.nameLabel.textColor =[UIColor colorWithHexString:@"#0B1E30"];
    self.timeLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel = entity;
    VPCommentaryModel *commentModel = cellModel.dataSource;
    [self.headImageView xx_setImageWithURLStr:commentModel.smallHeadPhoto placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
    self.nameLabel.text = commentModel.name;
    self.timeLabel.text = commentModel.dataTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
