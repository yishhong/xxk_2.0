//
//  VPDriveTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDriveTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@implementation VPDriveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString * dravString =cellModel.dataSource;
    self.draveLabel.text =dravString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
