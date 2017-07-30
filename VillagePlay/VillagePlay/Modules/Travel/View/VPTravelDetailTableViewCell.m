//
//  VPTravelDetailTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelDetailTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPTravelDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor =[UIColor VPTitleColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * dic =cellModel.dataSource;
    self.image_icon.image =[UIImage imageNamed:dic[@"image"]];
    self.titleLabel.text =dic[@"title"];
    if ([dic[@"hide"]isEqualToString:@""]) {
        
        self.jumpImageView.hidden =YES;
        
    }else{
    
        self.jumpImageView.hidden =NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
