//
//  VPOrderCell.h
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *orderIcon;
@property (strong, nonatomic) IBOutlet UILabel *lb_title;

@property (strong, nonatomic) IBOutlet UIView *lineView;
@end
