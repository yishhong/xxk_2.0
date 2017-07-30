//
//  VPInfoStatusCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPInfoStatusCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *topImage;

/**
 标题
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_title;

/**
 使用时间
 */
@property (strong, nonatomic) IBOutlet UILabel *lb_date;

@end
