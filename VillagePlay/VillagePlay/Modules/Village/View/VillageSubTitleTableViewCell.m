//
//  VillageSubTitleTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VillageSubTitleTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "NSMutableAttributedString+AttributedString.h"

@implementation VillageSubTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSString * contentString =[NSString stringWithFormat:@"    %@",cellModel.dataSource];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    attributedString =[attributedString attributedString:contentString paragraph:8];
    self.subTitleLabel.attributedText = attributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
