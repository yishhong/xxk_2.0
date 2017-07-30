//
//  VPOrderIdAndStatusCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPOrderIdAndStatusCell.h"
#import "UITableViewCell+DataSource.h"
#import "VPTravelRefundDetailModel.h"
#import "XXCellModel.h"

@implementation VPOrderIdAndStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    VPTravelRefundDetailModel * travelRefundDetailModel =cellModel.dataSource;
    self.lb_orderId.text =[NSString stringWithFormat:@"订单号：%@",travelRefundDetailModel.orderNum];
    switch (travelRefundDetailModel.refundState) {
        case 0:
            self.lb_status.text =@"退款中";
            break;
        case 1:
            self.lb_status.text =@"退款中";
            break;
        case 2:
            self.lb_status.text =@"退款成功";
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
