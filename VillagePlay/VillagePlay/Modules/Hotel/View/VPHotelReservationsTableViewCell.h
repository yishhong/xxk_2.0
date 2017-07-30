//
//  VPHotelReservationsTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VPHotelReservationsTableViewCell;
@protocol VPHotelReservationsTableViewCellDelegate <NSObject>

@end

@interface VPHotelReservationsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *roomImageView;
@property (strong, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cancelLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *reservationButton;
@property (strong, nonatomic) IBOutlet UILabel *roomSizeLabel;
@property (strong, nonatomic)id<VPHotelReservationsTableViewCellDelegate>delegate;
@end
