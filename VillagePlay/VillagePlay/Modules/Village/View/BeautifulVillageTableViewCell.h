//
//  BeautifulVillageTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautifulVillageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *villageImageView;
@property (strong, nonatomic) IBOutlet UIView *belowView;
@property (strong, nonatomic) IBOutlet UILabel *villageNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *villageTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;

@end
