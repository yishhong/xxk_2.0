//
//  VPTicketReservationTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPTicketReservationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ticketType;
@property (strong, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *payWayLabel;
@property (strong, nonatomic) IBOutlet UILabel *reservationLabel;
@property (strong, nonatomic) IBOutlet UIView *reservationView;

@end
