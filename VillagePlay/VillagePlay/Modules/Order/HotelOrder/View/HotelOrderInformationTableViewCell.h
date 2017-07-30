//
//  HotelOrderInformationTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelOrderInformationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *checkPeopleNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *checkDayNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *checkDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *CheckOutDateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@end
