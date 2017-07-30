//
//  VPTicketSubitInformationModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketSubitInformationModel.h"

@implementation VPTicketSubitInformationModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"lstGoods":[VPTravelSubitLstGoods class]};
}

@end
