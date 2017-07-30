//
//  VPDriveContentTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDriveContentTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"

@implementation VPDriveContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString * contentString =cellModel.dataSource;
    self.contentLabel.text =contentString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
