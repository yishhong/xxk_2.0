//
//  VPMagazineAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPMagazineAPI : VPAPI

/**
 微刊列表

 @param params 微刊列表信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)magazineListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
