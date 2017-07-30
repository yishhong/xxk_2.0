//
//  VPTicketAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

@interface VPTicketAPI : VPAPI


/**
 门票列表

 @param params 门票列表信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


/**
 民宿下单

 @param params 下单信息提交
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketOrderWriteParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


@end
