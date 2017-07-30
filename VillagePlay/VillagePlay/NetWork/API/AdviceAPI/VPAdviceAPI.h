//
//  VPAdviceAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPAdviceAPI : VPAPI

/**
 *  提交个人反馈
 *
 *  @param userId   用户ID
 *  @param contents 反馈详情
 *  @param success  成功的回调
 *  @param failure  失败的回调
 */
- (void)submitFeedbackWithUserId:(NSString *)userId contents:(NSString *)contents success:(Success)success failure:(Failure)failure;


@end
