//
//  VPCouponCell.h
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPCouponCell : UITableViewCell

/**
 背景颜色View
 */
@property (strong, nonatomic) IBOutlet UIView *bgView;

/**
 优惠金额
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_money;

/**
 解释文本
 */
@property (strong, nonatomic) IBOutlet UILabel *desc;

/**
 标题文本
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_title;

/**
 有效期
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_date;

@end
