//
//  VPTicketReservationController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPParentClassScrollController.h"
#import <Foundation/Foundation.h>
#import "VPTicketDetailModel.h"
#import "VPWebTableViewCell.h"

@interface VPTicketReservationController : VPParentClassScrollController

+ (instancetype)instantiation;

@property (strong, nonatomic) VPTicketDetailModel *ticketDetailModel;

@end
