//
//  VPTravelOrderViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPTravelOrderViewModel : NSObject

/**
 旅游订单列表

 @param state (0待付款,1已完成,2已取消,3已退款,4待出行)
 @param isFirstLoading 是否首次刷新
 @param success 成功回调
 @param failure 失败回调
 */
-(void)travelOrderListState:(NSString *)state isFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

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
