//
//  VPMainAPI.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPMainAPI : VPAPI


/**
 加载首页数据

 @param parmas 接口参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)loadMainListWithParams:(NSDictionary *)parmas success:(Success)success failure:(Failure)failure;


@end
