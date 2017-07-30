//
//  VPTiketOrderDetailOrderModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTiketOrderDetailOrderModel.h"

@implementation VPTicketGoods


@end

@implementation VPTicketRegisteRecord

@end

@implementation VPTiketOrderDetailOrderModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"ticketRegisteRecord":[VPTicketRegisteRecord class],
             @"ticketGoods":[VPTicketGoods class]};
}

@end
