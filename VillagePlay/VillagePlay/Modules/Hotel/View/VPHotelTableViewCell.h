//
//  VPHotelTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPHotelTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIView *backgorund;
@end