//
//  VPTicketReservationTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketReservationTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActivityGoodsModel.h"

@implementation VPTicketReservationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ticketType.textColor =[UIColor VPTitleColor];
    self.originalPriceLabel.textColor =[UIColor VPDetailColor];
    self.currentPriceLabel.textColor =[UIColor VPRedColor];
    self.reservationView.layer.borderColor =[UIColor navigationTintColor].CGColor;
    self.reservationView.layer.borderWidth =1.0f;
    self.reservationLabel.textColor =[UIColor whiteColor];
    self.payWayLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPActivityGoodsModel *activityGoodsModel =cellModel.dataSource;
    self.ticketType.text =activityGoodsModel.goodsName;
    NSString * originalPrice = [@"原价" stringByAppendingString:[NSString stringWithFormat:@"￥%.2lf",activityGoodsModel.originalPrice]];
    self.originalPriceLabel.text =originalPrice;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",originalPrice]];
    
    [content addAttributes:@{NSForegroundColorAttributeName:
                                 [UIColor VPDetailColor],
                             NSStrikethroughStyleAttributeName:
                                 @(NSUnderlinePatternSolid| NSUnderlineStyleSingle),
                             NSStrokeColorAttributeName:[UIColor VPDetailColor],
                             //                                 NSStrokeWidthAttributeName:@(1)
                             }
                     range:NSMakeRange(0,self.originalPriceLabel.text.length)
     ];
    self.originalPriceLabel.attributedText = content;
    self.currentPriceLabel.text =[NSString stringWithFormat:@"现价￥%.2lf",activityGoodsModel.presentPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
