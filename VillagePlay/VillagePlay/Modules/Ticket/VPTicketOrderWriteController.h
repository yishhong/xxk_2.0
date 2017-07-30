//
//  VPTicketOrderWriteController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPTicketDetailModel.h"

@interface VPTicketOrderWriteController : VPBaseViewController

+ (instancetype)instantiation;

@property (strong, nonatomic)VPTicketDetailModel *ticketDetailModel;

@end
