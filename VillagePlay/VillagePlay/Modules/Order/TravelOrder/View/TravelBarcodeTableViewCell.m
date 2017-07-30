//
//  TravelBarcodeTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelBarcodeTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"

@implementation TravelBarcodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString *string =cellModel.dataSource;
    self.nameLabel.text =string;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
