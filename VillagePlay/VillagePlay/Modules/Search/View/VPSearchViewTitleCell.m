//
//  VPSearchViewTitleCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewTitleCell.h"
#import "UITableViewCell+DataSource.h"

@implementation VPSearchViewTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithEntity:(id)entity{
    if(entity){
        NSDictionary * info = (NSDictionary *)entity;
        self.titleLabel.text = info[@"title"];
        self.titleLabel.textColor = info[@"color"];
    }
}

@end
