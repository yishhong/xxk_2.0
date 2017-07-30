//
//  VPNumberTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#define dtScreenWidth [UIScreen mainScreen].bounds.size.width

#import "VPNumberTableViewCell.h"
#import "VPQuantityView.h"
#import "XXNibConvention.h"
#import "UIColor+HUE.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActivityGoodsModel.h"
#import "NSObject+KVO.h"
#import "FBKVOController.h"

@interface VPNumberTableViewCell()

@property (strong, nonatomic)VPQuantityView * numberView;
@property (strong, nonatomic) VPActivityGoodsModel * activityGoodsModel;

@end

@implementation VPNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.peopleLabel.textColor = [UIColor VPContentColor];
    
    self.currentPriceLabel.textColor=[UIColor VPRedColor];
    
    [self.travelNumberView addSubview:self.numberView];
    self.limitLabel.textColor =[UIColor navigationTintColor];
    self.limitLabel.layer.borderWidth =0.5;
    self.limitLabel.layer.borderColor =[UIColor navigationTintColor].CGColor;
    self.ticketNumberLabel.textColor =[UIColor navigationTintColor];
    [self.numberView addObserver:self forKeyPath:@"currentAmount" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    self.activityGoodsModel = cellModel.dataSource;
    
    
//        [self.KVOController unobserveAll];
//        [self.KVOController observe:self.numberView keyPath:@"currentAmount" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//    
//            NSInteger selectedAmout = [change[NSKeyValueChangeNewKey] integerValue];
//            activityGoodsModel.selectedNum =@(selectedAmout);
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"VPtotalPriceChangeNotification" object:@(selectedAmout)];
//        }];
//    
        self.peopleLabel.text = self.activityGoodsModel.goodsName;
    
        NSString * originalPrice = [@"原价" stringByAppendingString:[NSString stringWithFormat:@"%.2lf",self.activityGoodsModel.originalPrice]];
        self.primeCostLabel.text = originalPrice;
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",originalPrice]];
    
        [content addAttributes:@{NSForegroundColorAttributeName:
                                         [UIColor VPDetailColor],
                                     NSStrikethroughStyleAttributeName:
                                         @(NSUnderlinePatternSolid| NSUnderlineStyleSingle),
                                     NSStrokeColorAttributeName:[UIColor VPDetailColor],
                                     //                                 NSStrokeWidthAttributeName:@(1)
                                     }
                             range:NSMakeRange(0,self.primeCostLabel.text.length)
             ];
        self.primeCostLabel.attributedText = content;
        self.currentPriceLabel.text =[ @"现价" stringByAppendingString:[NSString stringWithFormat:@"%.2lf",self.activityGoodsModel.presentPrice]];
        self.numberView.currentAmount = [self.activityGoodsModel.selectedNum integerValue];
        self.numberView.purchaseNum = self.activityGoodsModel.purchaseNum;
        self.numberView.buyNum = self.activityGoodsModel.buyNum;
        if (self.activityGoodsModel.purchaseNum==0) {
            self.limitLabel.hidden=YES;
            self.ticketNumberLabel.hidden =YES;
        }else{
            self.limitLabel.hidden=NO;
            self.ticketNumberLabel.hidden=NO;
            self.ticketNumberLabel.text =[NSString stringWithFormat:@"每人限购%ld张",(long)self.activityGoodsModel.purchaseNum];
        }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSLog(@"old: %@", [change objectForKey:NSKeyValueChangeOldKey]);
    NSLog(@"old: %@", [change objectForKey:NSKeyValueChangeNewKey]);
    NSLog(@"context: %@", context);
    if(self.activityGoodsModel){
        NSInteger selectedAmout = [change[NSKeyValueChangeNewKey] integerValue];
        self.activityGoodsModel.selectedNum = @(selectedAmout);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"VPtotalPriceChangeNotification" object:@(selectedAmout)];
    }
}
- (void)dealloc{
    self.activityGoodsModel = nil;
    [self.numberView removeObserver:self forKeyPath:@"currentAmount"];
}

-(VPQuantityView *)numberView{
    
    if (!_numberView) {
        
        _numberView = [VPQuantityView xx_instantiateFromNib];
        _numberView.frame = CGRectMake(0,0, 107, 32);
    }
    return _numberView;
}

@end
