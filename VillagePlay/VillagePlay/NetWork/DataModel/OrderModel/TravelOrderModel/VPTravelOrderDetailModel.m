//
//  VPTravelOrderDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderDetailModel.h"

@implementation VPTravelOrderDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"lstGoods":[VPTravelSubitLstGoods class],
             };
}

@end
