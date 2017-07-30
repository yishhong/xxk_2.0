//
//  VPHotelRemoveTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelRemoveTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPHotelRemoveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =[UIColor controllerBackgroundColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString * ruleString =cellModel.dataSource;
    self.cancelLabel.text=ruleString;
}

@end
