//
//  VPAddressDateTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPAddressDateTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *checkDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *checkWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *outDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *outWeekLabel;
@property (strong, nonatomic) IBOutlet UIView *checkView;
@property (strong, nonatomic) IBOutlet UIView *outView;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
@property (strong, nonatomic) IBOutlet UIButton *outButton;

@end
