//
//  VPTicketDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketDetailModel.h"

@implementation VPTicketDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"ticket":@"VPTicketListModel",
             @"ticketGoods":[VPActivityGoodsModel class]};
}

@end