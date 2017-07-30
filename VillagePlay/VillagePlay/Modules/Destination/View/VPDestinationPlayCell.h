//
//  VPDestinationPlayCell.h
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPDestinationPlayCell : UITableViewCell

/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *picture;

/**
 *  标题
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_title;

/**
 *  线路
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_route;

/**
 *  周期 格式为：2天|适合5.6.7月
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_period;
/**
 *  分割线
 */
@property (strong, nonatomic) IBOutlet UIView *lineView;

@end
