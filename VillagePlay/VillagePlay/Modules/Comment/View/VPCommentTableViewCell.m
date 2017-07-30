//
//  VPCommentTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentTableViewCell.h"
#import "UIColor+HUE.h"
#import "AMRatingControl.h"
#import "VPCommentCollectionViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPCommentaryModel.h"
#import "UIImageView+VPWebImage.h"

@interface VPCommentTableViewCell()

@property(strong,nonatomic)AMRatingControl * rateCtl;

@end

@implementation VPCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImageView.layer.cornerRadius =20;
    self.headImageView.layer.masksToBounds =YES;
    self.nameLabel.textColor =[UIColor VPTitleColor];
    self.timeLabel.textColor =[UIColor VPDetailColor];
    
    AMRatingControl * rateCtl=[[AMRatingControl alloc]initWithLocation:CGPointMake(0, 0) emptyImage:[UIImage imageNamed:@"icon_ tour_star_gray"] solidImage:[UIImage imageNamed:@"icon_ tour_star_blue"] andMaxRating:5];
    rateCtl.frame=CGRectMake(0, 0, 23*5, 20);
    rateCtl.userInteractionEnabled = NO;
    [self.starView addSubview:rateCtl];
    self.rateCtl =rateCtl;

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    VPCommentaryModel * commentModel =cellModel.dataSource;
    [self.headImageView xx_setImageWithURLStr:commentModel.smallHeadPhoto placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
    self.rateCtl.rating =commentModel.star;
    self.nameLabel.text =commentModel.name;
    self.timeLabel.text =commentModel.dataTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
