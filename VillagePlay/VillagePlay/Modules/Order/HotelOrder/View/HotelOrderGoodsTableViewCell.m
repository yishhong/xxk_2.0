//
//  HotelOrderGoodsTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelOrderGoodsTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelOrderListModel.h"
#import "UIColor+HUE.h"
#import "UIImageView+VPWebImage.h"

@implementation HotelOrderGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =[UIColor controllerBackgroundColor];
    self.checkTimeLabel.textColor =[UIColor VPContentColor];
    self.outTimeLabel.textColor =[UIColor VPContentColor];
    self.priceLabel.textColor =[UIColor VPTitleColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    VPHotelOrderListModel *hotelOrderListModel =cellModel.dataSource;
    self.checkTimeLabel.text =hotelOrderListModel.enterDataTime;
    self.outTimeLabel.text =hotelOrderListModel.outDataTime;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",hotelOrderListModel.price];
    [self.hotelOrderImage xx_setImageWithURLStr:hotelOrderListModel.roomImg placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
