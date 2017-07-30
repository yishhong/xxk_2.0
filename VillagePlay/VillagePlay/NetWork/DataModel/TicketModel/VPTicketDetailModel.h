//
//  VPTicketDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPActivityGoodsModel.h"
#import "VPTicketListModel.h"

@interface VPTicketDetailModel : VPBaseModel

@property (nonatomic, strong) VPTicketListModel *ticket;

@property (nonatomic, strong) NSArray <VPActivityGoodsModel*>*ticketGoods;

@end
