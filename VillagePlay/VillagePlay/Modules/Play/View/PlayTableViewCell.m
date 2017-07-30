//
//  PlayTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "PlayTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPPlayListModel.h"
#import "UIImageView+VPWebImage.h"

@implementation PlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.playTitleLabel.textColor =[UIColor VPContentColor];
    self.addressNameLabel.textColor =[UIColor VPDetailColor];
    self.timeLabel.textColor =[UIColor navigationTintColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPPlayListModel * playListModel =cellModel.dataSource;
    if([playListModel.imgs count]>0){
        [self.playImageView xx_setImageWithURLStr:[playListModel.imgs objectAtIndex:0] placeholder:[UIImage imageNamed:@"vp _destination_play_Iamge"]];
    }else{
        [self.playImageView xx_setImageWithURLStr:@"" placeholder:[UIImage imageNamed:@"vp _destination_play_Iamge"]];
    }
    self.playTitleLabel.text =playListModel.title;
    self.addressNameLabel.text = playListModel.lineName;
    self.timeLabel.text = [playListModel.tagList componentsJoinedByString:@"|"];
}

@end
