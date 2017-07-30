//
//  VPLiveHeadTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveHeadTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPLiveDetailModel.h"
#import "UIImageView+VPWebImage.h"
#import "UIColor+HUE.h"

@implementation VPLiveHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.liveName.textColor =[UIColor VPTitleColor];
    self.liveTimeLabel.textColor =[UIColor VPDetailColor];
    self.liveImageView.layer.cornerRadius =35/2;
    self.liveImageView.layer.masksToBounds =YES;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPLiveDetailModel *liveDetailModel =cellModel.dataSource;
    [self.liveImageView xx_setImageWithURLStr:liveDetailModel.photoUrl placeholder:[UIImage imageNamed:@"vp_headPhoto"]];
    self.liveName.text =@"下乡客MM";
    self.liveTimeLabel.text =liveDetailModel.addTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
