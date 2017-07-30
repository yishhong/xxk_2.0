//
//  VPNumberTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPQuantityView.h"

@interface VPNumberTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel  *peopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *primeCostLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *limitLabel;
@property (strong, nonatomic) IBOutlet UILabel *ticketNumberLabel;
@property (strong, nonatomic) IBOutlet UIView *travelNumberView;
@end
