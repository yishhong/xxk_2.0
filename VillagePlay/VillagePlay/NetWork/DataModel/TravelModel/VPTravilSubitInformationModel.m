//
//  VPTravilSubitInformationModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/6.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravilSubitInformationModel.h"

@implementation VPTravilSubitInformationModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"lstGoods":[VPTravelSubitLstGoods class]};
}

@end
