//
//  OrderWayTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "OrderWayTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPHotelOrderListModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@interface OrderWayTableViewCell ()

@property (strong, nonatomic)VPHotelOrderListModel *hotelOrderListModel;

@end

@implementation OrderWayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.placeButton setTitleColor:[UIColor VPContentColor] forState:UIControlStateNormal];
    self.placeButton.layer.cornerRadius =2.0f;
    self.placeButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.placeButton.layer.borderWidth =1.0f;
    self.placeButton.layer.cornerRadius =2.0f;
    self.placeButton.hidden =YES;
    
    [self.payButton setTitleColor:[UIColor VPContentColor] forState:UIControlStateNormal];
    self.payButton.layer.cornerRadius =2.0f;
    self.payButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.payButton.layer.borderWidth =1.0f;
    self.payButton.layer.cornerRadius =2.0f;
    self.payButton.hidden =YES;

}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    self.hotelOrderListModel =cellModel.dataSource;
    /**
     房间状态(0待付款,1预订取消，2待确认，3等待入住，5已完成（已入住），6已取消退款中，7已取消退款中，8已完成未入住，9已取消已退款)
     */
    self.placeButton.hidden =YES;
    self.payButton.hidden =NO;
    switch (self.hotelOrderListModel.orderState) {
            
        case 0:
            [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
            break;
            
        case 1:
            [self.placeButton setTitle:@"再次预订" forState:UIControlStateNormal];
            self.placeButton.hidden =NO;
            [self.payButton setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
            
        case 2:
            self.payButton.hidden =YES;
            self.placeButton.hidden =YES;
            break;
            
        case 3:
            self.payButton.hidden =YES;
            self.placeButton.hidden =YES;
            break;
        
        case 5:
            [self.payButton setTitle:@"再次预订" forState:UIControlStateNormal];
            break;
            
        case 8:
            [self.payButton setTitle:@"再次预订" forState:UIControlStateNormal];
            break;
        case 6|7:
            [self.payButton setTitle:@"退款详情" forState:UIControlStateNormal];
            break;

        case 9:
            [self.payButton setTitle:@"退款详情" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)placeAction:(UIButton *)sender {
    
    sender.tag =18;
    [self xx_cellClickAtView:sender];
}
- (IBAction)payAction:(UIButton *)sender {
    
    sender.tag =self.hotelOrderListModel.orderState;
    [self xx_cellClickAtView:sender];
}

@end
