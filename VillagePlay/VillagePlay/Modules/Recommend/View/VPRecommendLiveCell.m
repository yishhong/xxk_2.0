//
//  VPRecommendLiveCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendLiveCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPLiveInfoModel.h"
#import "UIImageView+VPWebImage.h"
#import "NSString+NumberRound.h"

@implementation VPRecommendLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];

    for (int i=0; i<2; i++) {
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTapGesture:)];
        if (i==0) {
            
            [self.leftView addGestureRecognizer:tap];
            self.leftView.tag=i;
            
        }else{
            
            [self.rightView addGestureRecognizer:tap];
            self.rightView.tag=i;
        }
    }
}

- (void)tapTapGesture:(UITapGestureRecognizer *)tap{
    [self xx_cellClickAtView:tap.view];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *dict = cellModel.dataSource;
    if(dict[@"left"]){
        VPLiveInfoModel *liveModel = dict[@"left"];
        NSDictionary * cellInfo =[liveModel liveStateForInfo];
        [self.leftView.livePhoto xx_setImageWithURLStr:liveModel.photoUrl placeholder:[UIImage imageNamed:@""]];
        self.leftView.lb_title.text = liveModel.title;
        self.leftView.lb_watch.text = [NSString stringWithFormat:@"%@次观看",[[@(liveModel.viewNum) stringValue] numericalConversion]];
        self.leftView.lb_liveState.text =cellInfo[@"title"];
        self.leftView.lb_liveState.textColor =cellInfo[@"color"];
        self.leftView.liveStateImage.image =[UIImage imageNamed:cellInfo[@"image"]];
    }
    if(dict[@"right"]){
        VPLiveInfoModel *liveModel = dict[@"right"];
        NSDictionary * cellInfo =[liveModel liveStateForInfo];
        self.rightView.hidden = NO;
        [self.rightView.livePhoto xx_setImageWithURLStr:liveModel.photoUrl placeholder:[UIImage imageNamed:@""]];
        self.rightView.lb_title.text = liveModel.title;
        self.rightView.lb_watch.text = [NSString stringWithFormat:@"%@次观看",[[@(liveModel.viewNum) stringValue] numericalConversion]];
        self.rightView.lb_liveState.text = cellInfo[@"title"];
        self.rightView.lb_liveState.textColor =cellInfo[@"color"];
        self.rightView.liveStateImage.image =[UIImage imageNamed:cellInfo[@"image"]];

    }else{
        self.rightView.hidden = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
