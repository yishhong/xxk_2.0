//
//  PlayTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *playImageView;
@property (strong, nonatomic) IBOutlet UILabel *playTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
