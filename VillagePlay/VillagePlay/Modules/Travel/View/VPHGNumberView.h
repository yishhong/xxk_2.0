//
//  VPHGNumberView.h
//  VillagePlay
//
//  Created by  易述宏 on 2017/1/13.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPHGNumberViewDelegate <NSObject>

- (void)VPCurrentAmount:(NSInteger)currentAmount;

@end

@interface VPHGNumberView : UIView<UITextFieldDelegate>

/**
 减按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *subtractButton;

/**
 加减数量文本框
 */
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;

/**
 加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *addButton;


/**
 当前数量
 */
@property(assign,nonatomic) NSInteger currentAmount;

/**
 最小值
 */
@property(assign,nonatomic) NSInteger minAmount;

/**
 最大值
 */
@property(assign,nonatomic) NSInteger maxAmount;

/**
 限票剩余
 */
@property(assign,nonatomic) NSInteger buyNum;

/**
 限制人数
 */
@property(assign,nonatomic) NSInteger purchaseNum;

@property (strong, nonatomic)id<VPHGNumberViewDelegate>delegate;


@end
