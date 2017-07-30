//
//  VPMessageCell.h
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *messageIcon;
@property (strong, nonatomic) IBOutlet UILabel *lb_title;
@property (strong, nonatomic) IBOutlet UILabel *lb_notRead;

@end
