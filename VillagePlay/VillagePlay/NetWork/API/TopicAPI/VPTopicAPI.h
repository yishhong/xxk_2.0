//
//  VPTopicAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTopicAPI : VPAPI

/**
 *  专题列表
 *
 *  @param params  列表信息
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)topicListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
