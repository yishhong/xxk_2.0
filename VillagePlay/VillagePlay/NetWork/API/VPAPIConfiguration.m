//
//  VPAPIConfiguration.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPIConfiguration.h"

@implementation VPAPIConfiguration
- (NSString *)serverURL{
    return @"https://api.xiaxiangke.com/";
#ifdef DEBUG
    return @"http://apitest.xiaxiangke.com/";
#else
    return @"https://api.xiaxiangke.com/";
#endif

}
@end
