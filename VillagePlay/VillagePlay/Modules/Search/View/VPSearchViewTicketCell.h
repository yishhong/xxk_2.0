//
//  VPSearchViewTicketCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPSearchViewTicketCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ticketImage;
@property (strong, nonatomic) IBOutlet UILabel *lb_title;
@property (strong, nonatomic) IBOutlet UILabel *lb_subTitle;
@property (strong, nonatomic) IBOutlet UILabel *lb_price;

@end