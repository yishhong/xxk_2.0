//
//  VPTiketNumberTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTiketNumberTableViewCell.h"
#import "VPQuantityView.h"
#import "XXNibConvention.h"
#import "UIColor+HUE.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActivityGoodsModel.h"
#import "NSObject+KVO.h"
#import "FBKVOController.h"

@interface VPTiketNumberTableViewCell ()

@property(strong,nonatomic)VPQuantityView *numberView;

@property (strong, nonatomic) VPActivityGoodsModel * activityGoodsModel;

@end

@implementation VPTiketNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPContentColor];
    self.priceLabel.textColor =[UIColor VPRedColor];
    self.tricketNumberLabel.textColor =[UIColor VPContentColor];
    [self.tiketNumberView addSubview:self.numberView];
    [self.numberView addObserver:self forKeyPath:@"currentAmount" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    self.activityGoodsModel =cellModel.dataSource;
//    [self.KVOController unobserveAll];
//    [self.KVOController observe:self.numberView keyPath:@"currentAmount" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//        
//        NSInteger selectedAmout = [change[NSKeyValueChangeNewKey] integerValue];
//        activityGoodsModel.selectedNum =@(selectedAmout);
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"VPtotalPriceChangeNotification" object:@(selectedAmout)];
//    }];
//
//  self.numberView.
    
    
    self.nameLabel.text = self.activityGoodsModel.goodsName;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",self.activityGoodsModel.presentPrice];
    self.tricketNumberLabel.text =@"购买数量";
    self.numberView.currentAmount = [self.activityGoodsModel.selectedNum integerValue];
    self.numberView.purchaseNum = self.activityGoodsModel.purchaseNum;
    self.numberView.buyNum = self.activityGoodsModel.buyNum;
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSLog(@"old: %@", [change objectForKey:NSKeyValueChangeOldKey]);
    NSLog(@"old: %@", [change objectForKey:NSKeyValueChangeNewKey]);
    NSLog(@"context: %@", context);
    if(self.activityGoodsModel){
        NSInteger selectedAmout = [change[NSKeyValueChangeNewKey] integerValue];
        self.activityGoodsModel.selectedNum =@(selectedAmout);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VPtotalPriceChangeNotification" object:@(selectedAmout)];
    }
}
- (void)dealloc{
    self.activityGoodsModel = nil;
    [self.numberView removeObserver:self forKeyPath:@"currentAmount"];
}

-(VPQuantityView *)numberView{
    
    if (!_numberView) {
        
        _numberView = [VPQuantityView xx_instantiateFromNib];
        _numberView.frame = CGRectMake(0,0, self.tiketNumberView.width, self.tiketNumberView.height);
    }
    return _numberView;
}

@end
