//
//  VPHotelTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelTableViewCell.h"
#import "UIColor+HUE.h"
#import "UIImageView+VPWebImage.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelListModel.h"
#import "XXCellModel.h"
#import "NSMutableAttributedString+AttributedString.h"

@implementation VPHotelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.nameLabel.textColor=[UIColor VPTitleColor];
    self.distanceLabel.textColor =[UIColor VPDetailColor];
    self.backgorund.backgroundColor =[UIColor controllerBackgroundColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPHotelListModel *hotelListModel=cellModel.dataSource;
    [self.headImageView xx_setImageWithURLStr:hotelListModel.imgUrl placeholder:[UIImage imageNamed:@"vp_list_big_Image"]];
    self.nameLabel.text =hotelListModel.name;
    self.distanceLabel.text =[NSString stringWithFormat:@"距离我当前位置:%@km",hotelListModel.juli];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
   attributedString = [attributedString attributedString:[NSString stringWithFormat:@"￥%.2f起",hotelListModel.price]];

    self.priceLabel.attributedText =attributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
