//
//  VPLiveListAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPLiveListAPI :VPAPI

/**
 直播列表

 @param params 直播信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)liveListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
