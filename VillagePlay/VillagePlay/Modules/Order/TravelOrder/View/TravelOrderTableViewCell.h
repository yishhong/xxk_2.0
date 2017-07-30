//
//  TravelOrderTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelOrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *orderImageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *tickeNumbertLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end
