//
//  VPRecommendMenuCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendMenuCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VPRecommendMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftView.userInteractionEnabled =YES;
    self.centreView.userInteractionEnabled =YES;
    self.rightView.userInteractionEnabled =YES;
    for (int i=0; i<3; i++) {
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTapGesture:)];
        if (i==0) {
            [self.leftView addGestureRecognizer:tap];
            self.leftView.tag=i;
        }else if (i==1){
            [self.centreView addGestureRecognizer:tap];
            self.centreView.tag=i;
        }else{
          [self.rightView addGestureRecognizer:tap];
            self.rightView.tag=i;
        }
    }
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSMutableArray *dataSource = cellModel.dataSource;
    [self.leftView setDataSource:dataSource[0]];
    [self.centreView setDataSource:dataSource[1]];
    [self.rightView setDataSource:dataSource[2]];
}

-(void)tapTapGesture:(UITapGestureRecognizer *)tap{
    [self xx_cellClickAtView:tap.view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
