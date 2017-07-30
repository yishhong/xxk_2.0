//
//  VPLiveTextTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveTextTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "VPLiveDetailModel.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"

@implementation VPLiveTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentTextLabel.textColor =[UIColor VPContentColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    NSString * contentString =cellModel.dataSource;
    self.contentTextLabel.text =contentString;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
