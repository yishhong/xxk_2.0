//
//  VPDestinationPlayCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationPlayCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPPlayListModel.h"
#import "UIImageView+VPWebImage.h"

@implementation VPDestinationPlayCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lb_title.text = @"";
    self.lb_route.text = @"";
    self.lb_period.text = @"";
    self.picture.layer.masksToBounds = YES;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPPlayListModel *playListModel = cellModel.dataSource;
    if([playListModel.imgs count]>0){
        [self.picture xx_setImageWithURLStr:[playListModel.imgs objectAtIndex:0] placeholder:[UIImage imageNamed:@"vp _destination_play_Iamge"]];
    }else{
        [self.picture xx_setImageWithURLStr:@"" placeholder:[UIImage imageNamed:@"vp _destination_play_Iamge"]];
    }
    self.lb_title.text = playListModel.title;
    self.lb_route.text = playListModel.lineName;
    self.lb_period.text = [playListModel.tagList componentsJoinedByString:@"|"];
    if(cellModel.location == CellLocationEnd){
        self.lineView.hidden = YES;
    }else{
        self.lineView.hidden = NO;
    }
}

@end
