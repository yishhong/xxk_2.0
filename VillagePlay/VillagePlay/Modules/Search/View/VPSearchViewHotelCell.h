//
//  VPSearchViewHotelCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPSearchViewHotelCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lb_name;
@property (strong, nonatomic) IBOutlet UILabel *lb_price;
@property (strong, nonatomic) IBOutlet UILabel *lb_comment;

@property (strong, nonatomic) IBOutlet UIImageView *hotelPicture;

@property (strong, nonatomic) IBOutlet UIView *rateView;

@end
