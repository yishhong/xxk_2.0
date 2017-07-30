//
//  VPSettingExitCell.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSettingExitCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPSettingExitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.exitButton.enabled = NO;
}

- (void)xx_configCellWithEntity:(id)entity{
//    XXCellModel *cellModel = entity;
}


- (IBAction)exitButton:(id)sender {
    [self xx_cellClickAtView:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
