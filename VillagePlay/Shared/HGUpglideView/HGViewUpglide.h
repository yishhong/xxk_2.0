//
//  HGViewUpglide.h
//  HGDemo
//
//  Created by  易述宏 on 16/10/16.
//  Copyright © 2016年 JamesYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPOrderCouponModel.h"


typedef void(^HGViewUpglideBlock)(VPOrderCouponModel *orderCouponModel,NSString * couponCode,CGFloat discountMoney);


@interface HGViewUpglide : UIView

@property (strong, nonatomic)HGViewUpglideBlock tappBlock;

- (void)showAnimation:(BOOL)animation;
- (void)hideAnimation:(BOOL)animation;

- (void)fouCouponArray:(NSArray *)couponArray totalRealPrice:(CGFloat)totalRealPrice;

@end
