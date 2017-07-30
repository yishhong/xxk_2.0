//
//  VPVersionAPI.h
//  VillagePlay
//
//  Created by Apricot on 2017/1/14.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPVersionAPI : VPAPI

/**
 获取版本信息

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadVersionAPISuccess:(Success)success failure:(Failure)failure;

@end
