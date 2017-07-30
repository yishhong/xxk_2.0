//
//  VPBannerAPI.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPBannerAPI : VPAPI

/**
 获取城市的Banner

 @param cityID 城市ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadCityBannerWithCityID:(NSInteger)cityID success:(Success)success failure:(Failure)failure;
@end
