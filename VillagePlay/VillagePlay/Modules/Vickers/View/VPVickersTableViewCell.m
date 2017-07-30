//
//  VPVickersTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVickersTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPMagazineModel.h"
#import "UIImageView+VPWebImage.h"

@implementation VPVickersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.belowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.vickersImageView.layer.cornerRadius = 2;
    self.vickersImageView.layer.masksToBounds = YES;

}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPMagazineModel *magazineModel = cellModel.dataSource;
    [self.vickersImageView xx_setImageWithURLStr:magazineModel.photoUrl placeholder:[UIImage imageNamed:@"vp_topicDetail_Image"]];
    self.titleLabel.text = magazineModel.title;
    self.browsedLabel.text =[NSString stringWithFormat:@"%ld",magazineModel.shareNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
