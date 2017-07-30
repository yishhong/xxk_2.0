//
//  VPOrderIdAndStatusCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPOrderIdAndStatusCell : UITableViewCell

/**
 订单号
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_orderId;

/**
 订单状态
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_status;

@end
