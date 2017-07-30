//
//  VPDestinationTitleCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationTitleCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPDestinationTitleCell

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.lb_title.text = cellModel.dataSource;
}

@end
