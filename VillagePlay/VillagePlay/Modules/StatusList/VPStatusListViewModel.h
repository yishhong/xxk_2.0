//
//  VPStatusListViewModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
@interface VPStatusListViewModel : NSObject

/**
 民宿退款详情
 
 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelRefundDetailOrder:(NSString *)orderid success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 民宿获取订单状态
 
 @param params 民宿订单状态信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelOrderState:(NSString *)orderid success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 旅游退款详情
 
 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelRefundDetailRefundID:(NSString *)refundID success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 旅游退款详情
 
 @param params 退款信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketRefundDetailOrderNum:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;
/**
 *  行数
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  数据模型
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
- (XXCellModel *)cellForRowAtIndexPath:(NSInteger )index;

@end
