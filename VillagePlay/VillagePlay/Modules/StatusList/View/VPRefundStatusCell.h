//
//  VPRefundStatusCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPRefundStatusCell : UITableViewCell
/**
 *  退款单号
 */
@property (strong, nonatomic) IBOutlet UILabel *OrderNumberLabel;
/**
 *  退款金额
 */
@property (strong, nonatomic) IBOutlet UILabel *refundLabel;

/**
 状态
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_status;
@end
