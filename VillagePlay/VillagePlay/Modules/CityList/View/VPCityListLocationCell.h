//
//  VPCityListLocationCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPCityListLocationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *locationIcon;
@property (strong, nonatomic) IBOutlet UILabel *lb_title;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;

@end
