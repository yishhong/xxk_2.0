//
//  VPRecommendVillageCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendVillageCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPVillageModel.h"
#import "UIImageView+VPWebImage.h"

@implementation VPRecommendVillageCell


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
        VPVillageModel *villageModel = dict[@"left"];
        [self.leftView.villagePhoto xx_setImageWithURLStr:villageModel.image placeholder:[UIImage imageNamed:@"vp_destination_villageList_Iamge"]];
        self.leftView.lb_title.text = villageModel.name;
#warning 地址是否计算
        self.leftView.lb_distance.text = [NSString stringWithFormat:@"距离：%@km",villageModel.distance];

    }
    if(dict[@"right"]){
        self.rightView.hidden = NO;
        VPVillageModel *villageModel = dict[@"right"];
        [self.rightView.villagePhoto xx_setImageWithURLStr:villageModel.image placeholder:[UIImage imageNamed:@"vp_destination_villageList_Iamge"]];
        self.rightView.lb_title.text = villageModel.name;
#warning 地址是否计算
        self.rightView.lb_distance.text = [NSString stringWithFormat:@"距离：%@km",villageModel.distance];
    }else{
        self.rightView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
