//
//  VPHotelAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPHotelAPI : VPAPI


/**
 民宿列表

 @param params 列表信息
 @param success 回调成功
 @param failure 回调失败
 */
- (void)hotelListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
