//
//  VPTravelTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPTravelTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *travelImageView;

@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UILabel *travelTypeLabel;

@property (strong, nonatomic) IBOutlet UILabel *peopleNumLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
