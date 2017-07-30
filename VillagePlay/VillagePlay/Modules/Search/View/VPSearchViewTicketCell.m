//
//  VPSearchViewTicketCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewTicketCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPSearchModel.h"
#import "NSMutableAttributedString+AttributedString.h"
#import "UIImageView+VPWebImage.h"

@implementation VPSearchViewTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_subTitle.text = @"";
    self.lb_title.text = @"";
    self.lb_price.text = @"";
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPSearchModel *searchModel = cellModel.dataSource;
    
    self.lb_title.text = searchModel.title;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    attributedString = [attributedString attributedString:[NSString stringWithFormat:@"￥%@起",searchModel.price]];
    self.lb_price.attributedText =attributedString;
    
//    self.lb_subTitle.text = [NSString stringWithFormat:@"%@"]
    [self.ticketImage  xx_setImageWithURLStr:searchModel.img placeholder:[UIImage imageNamed:@""]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
