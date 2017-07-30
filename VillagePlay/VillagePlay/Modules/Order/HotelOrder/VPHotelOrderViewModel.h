//
//  VPHotelOrderViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPHotelOrderListModel.h"

@interface VPHotelOrderViewModel : NSObject


/**
 民宿订单列表

 @param type 订单类型
 @param key <#key description#>
 @param isFirstLoading 是否加载更多
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelOrderType:(NSString *)type key:(NSString *)key isFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

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


@end
