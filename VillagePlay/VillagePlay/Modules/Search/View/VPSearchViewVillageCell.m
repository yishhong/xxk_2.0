//
//  VPSearchViewVillageCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewVillageCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPSearchModel.h"
#import "UIImageView+VPWebImage.h"

@implementation VPSearchViewVillageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_title.text = @"";
    self.lb_subTitle.text = @"";
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPSearchModel *searchModel = cellModel.dataSource;
    self.lb_title.text = searchModel.title;
    [self.villagePicture xx_setImageWithURLStr:searchModel.img placeholder:[UIImage imageNamed:@""]];
    self.lb_subTitle.text = [searchModel.tagList componentsJoinedByString:@"·"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
