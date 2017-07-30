//
//  VPHotelOrderDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPHotelOrderDetailModel.h"

@interface VPHotelOrderDetailViewModel : NSObject

/**
 订单详情

 @param orderid 订单ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelDetailOrderid:(NSString *)orderid success:(void(^)())success failure:(void(^)(NSError * error))failure;


/**
 取消订单

 @param orderid 订单ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelCancelOrderID:(NSString *)orderid success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 删除订单

 @param orderid 订单ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hoteldeleteOrderID:(NSString *)orderid success:(void(^)())success failure:(void(^)(NSError * error))failure;

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
 民宿订单详情数据

 @return <#return value description#>
 */
- (VPHotelOrderDetailModel *)orederDetailModel;

/**
 删除订单按钮状态

 @param hotelOrderDetailModel
 @return return value description
 */
- (NSString *)deleteButtonString:(VPHotelOrderDetailModel *)hotelOrderDetailModel;

/**
 取消订单按钮

 @param hotelOrderDetailModel hotelOrderDetailModel description
 @return return value description
 */
- (NSString *)subscribeButtonString:(VPHotelOrderDetailModel *)hotelOrderDetailModel;

/**
 退款

 @param hotelOrderDetailModel <#hotelOrderDetailModel description#>
 @return <#return value description#>
 */
- (NSMutableDictionary *)refundString:(VPHotelOrderDetailModel *)hotelOrderDetailModel;


@end
