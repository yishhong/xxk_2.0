//
//  VPQuantityView.h
//  VillagePlay
//
//  Created by  易述宏 on 15/9/24.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPQuantityView : UIView

@property (weak, nonatomic) IBOutlet UIButton *subtractButton;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

//当前数量
@property(assign,nonatomic) NSInteger currentAmount;

//最小值
@property(assign,nonatomic) NSInteger minAmount;

//最大值
@property(assign,nonatomic) NSInteger maxAmount;

@property(assign,nonatomic) NSInteger buyNum;//限票剩余;

@property(assign,nonatomic) NSInteger purchaseNum;//限制人数

@end
