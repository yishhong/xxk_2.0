//
//  VPDestinationVillageCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationVillageCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"


@implementation VPDestinationVillageCell

-(void)awakeFromNib{
    [super awakeFromNib];
    for (int i=0; i<3; i++) {
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTapGesture:)];
        switch (i) {
            case 0:{
                [self.leftView addGestureRecognizer:tap];
                self.leftView.tag=i;
            }break;
            case 1:{
                [self.centerView addGestureRecognizer:tap];
                self.centerView.tag=i;
            }break;
            case 2:{
                [self.rightView addGestureRecognizer:tap];
                self.rightView.tag=i;
            }break;
            default:
                break;
        }
    }
}

- (void)tapTapGesture:(UITapGestureRecognizer *)tap{
    [self xx_cellClickAtView:tap.view];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSArray *villageArray = cellModel.dataSource;
    NSInteger villageCount = [villageArray count];
    for (int i =0; i<villageCount; i++) {
        VPVillageModel *villageModel = villageArray[i];
        switch (i) {
            case 0:{
                [self.leftView configData:villageModel];
            }break;
            case 1:{
                [self.centerView configData:villageModel];
            }break;
            case 2:{
                [self.rightView configData:villageModel];
            }break;
            default:
                break;
        }
    }
    self.centerView.hidden = villageCount>=2?NO:YES;
    self.rightView.hidden = villageCount>=3?NO:YES;
}


@end
