//
//  VPRefundStatusCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRefundStatusCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "NSMutableAttributedString+AttributedString.h"

@implementation VPRefundStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    self.OrderNumberLabel.text =[NSString stringWithFormat:@"订单号%@",cellInfo[@"orderID"]];
    self.lb_status.text =cellInfo[@"state"];
    NSMutableAttributedString * attributedString =[[NSMutableAttributedString alloc]init];
   attributedString = [attributedString rangeAttributedString:[NSString stringWithFormat:@"退款金额:￥%@",cellInfo[@"price"]] changeColorString:[NSString stringWithFormat:@"￥%@",cellInfo[@"price"]]];
    self.refundLabel.attributedText =attributedString;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
