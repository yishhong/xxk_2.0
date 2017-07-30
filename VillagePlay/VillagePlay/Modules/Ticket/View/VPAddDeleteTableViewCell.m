//
//  VPAddDeleteTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAddDeleteTableViewCell.h"
#import "VPQuantityView.h"
#import "XXNibConvention.h"
#import "UIColor+HUE.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActivityGoodsModel.h"
#import "NSObject+KVO.h"
#import "FBKVOController.h"
#import "UIButton+TouchAreaInsets.h"

@interface VPAddDeleteTableViewCell ()

@property(strong, nonatomic)VPQuantityView *quantityView;

@end

@implementation VPAddDeleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressNameLabel.textColor =[UIColor VPContentColor];
    self.priceLabel.textColor =[UIColor VPRedColor];
    self.buyNumberLabel.textColor =[UIColor VPContentColor];
    [self.numberView addSubview:self.quantityView];
    [self.deleteButton setTouchAreaInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
}
- (IBAction)deleteAction:(UIButton *)sender {
    
    sender.tag =10;
    [self xx_cellClickAtView:sender];

}


- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel *cellModel =entity;
    VPActivityGoodsModel * activityGoodsModel =cellModel.dataSource;
    [self.KVOController unobserveAll];
    [self.KVOController observe:self.quantityView keyPath:@"currentAmount" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        NSInteger selectedAmout = [change[NSKeyValueChangeNewKey] integerValue];
        activityGoodsModel.selectedNum =@(selectedAmout);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"VPtotalPriceChangeNotification" object:@(selectedAmout)];
    }];
    self.addressNameLabel.text =activityGoodsModel.goodsName;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",activityGoodsModel.presentPrice];
    self.buyNumberLabel.text =@"购买数量";
    self.quantityView.currentAmount = [activityGoodsModel.selectedNum integerValue];
    self.quantityView.purchaseNum =activityGoodsModel.purchaseNum;
    self.quantityView.buyNum =activityGoodsModel.buyNum;
    //    if (activityGoodsModel.purchaseNum==0) {
    //        self.limitLabel.hidden=YES;
    //        self.ticketNumberLabel.hidden =YES;
    //    }else{
    //
    //        self.limitLabel.hidden=NO;
    //        self.ticketNumberLabel.hidden=NO;
    //        self.ticketNumberLabel.text =[NSString stringWithFormat:@"每人限购%ld张",(long)activityGoodsModel.purchaseNum];
    //    }
}

-(VPQuantityView *)quantityView{
    
    if (!_quantityView) {
        
        _quantityView = [VPQuantityView xx_instantiateFromNib];
        _quantityView.frame = CGRectMake(0,0, self.numberView.width, self.numberView.height);
    }
    return _quantityView;
}

@end
