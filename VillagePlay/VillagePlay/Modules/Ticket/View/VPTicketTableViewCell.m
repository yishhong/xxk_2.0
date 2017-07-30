//
//  VPTicketTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPTicketListModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIImageView+VPWebImage.h"
#import "NSMutableAttributedString+AttributedString.h"

@implementation VPTicketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ticketImageView.layer.masksToBounds = YES;
    self.nameLabel.textColor =[UIColor VPTitleColor];
    self.distanceLabel.textColor =[UIColor VPDetailColor];
    self.aliasLabel.textColor =[UIColor navigationTintColor];
    self.nameLabel.text = @"";
    self.distanceLabel.text = @"";
    self.aliasLabel.text = @"";
    self.priceLabel.textColor =[UIColor VPRedColor];
    
    
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPTicketListModel * ticketListModel =cellModel.dataSource;
    self.nameLabel.text =ticketListModel.title;
    self.aliasLabel.text =ticketListModel.keyWord;
    [self.ticketImageView xx_setImageWithURLStr:ticketListModel.homePicture placeholder:[UIImage imageNamed:@"vp_list_big_Image"]];
    self.priceLabel.text =ticketListModel.regCost;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
