//
//  VPLiveDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPLiveDetailAPI : VPAPI


/**
 直播详情

 @param params 直播详情信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)liveDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
