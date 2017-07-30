//
//  VPTopicDetailAPI.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTopicDetailAPI : VPAPI

/**
 *  专题详情
 *
 *  @param params  专题详情信息
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)topicDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

@end
