//
//  VPTravelOrderDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPTravelOrderDetailModel.h"

@interface VPTravelOrderDetailViewModel : NSObject

/**
 旅游订单详情

 @param ceid 订单ID
 @param success 成功回调
 @param failure 失败回调
 */
-(void)travelOrderDetailCeid:(NSString *)ceid type:(NSInteger)type success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 删除订单

 @param orderNum 订单号
 @param success 成功回调
 @param failure 失败回调
 */
//- (void)travelDeleteOrder:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 退款详情

 @param refundID 退款ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelRefund:(NSInteger)refundID success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 取消订单

 @param orderNum 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelCancelOrderNum:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;

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
- (NSString *)refundString:(VPTravelOrderDetailModel *)travelOrderDetailModel;

/**
 订单数据

 @return <#return value description#>
 */
- (VPTravelOrderDetailModel *)orderDetailModel;

@end
