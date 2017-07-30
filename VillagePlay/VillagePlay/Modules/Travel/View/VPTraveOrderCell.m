//
//  VPTraveOrderCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTraveOrderCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPTraveOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor =[UIColor controllerBackgroundColor];
    self.nameLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * info = cellModel.dataSource;
    self.nameLabel.text = info[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
