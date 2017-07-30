//
//  VPTicketOrderDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPTiketOrderDetailOrderModel.h"

@interface VPTicketOrderDetailViewModel : NSObject

/**
 门票订单详情

 @param orderNum 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketOrderDetailOrderNum:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 取消订单

 @param orderNum 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketOrderCancelOrderNum:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 申请退款

 @param orderNum 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketRefundOrderNum:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  返回cell数目
 *
 *  @return cell数量
 */
- (NSInteger)numberOfRows;

/**
 *  获取指定行的cell
 *
 *  @param indexPath cell的坐标
 *
 *  @return 返回指定行的cellModel
 */
- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 按钮状态
 
 @param orderState 订单状态
 @param refundState 退款状态
 @return <#return value description#>
 */
- (NSDictionary *)orderStatus:(NSInteger)orderState refundState:(NSInteger)refundState;

/**
 30分钟自动取消文本
 
 @param travelOrderDetailModel 数据源
 @return <#return value description#>
 */
- (NSMutableDictionary *)refundString:(VPTiketOrderDetailOrderModel *)travelOrderDetailModel;

/**
 订单数据
 
 @return <#return value description#>
 */
- (VPTiketOrderDetailOrderModel *)orderDetailModel;


@end
