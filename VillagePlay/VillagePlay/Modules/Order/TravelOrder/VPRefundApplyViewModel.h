//
//  VPRefundApplyViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPRefundApplyViewModel : NSObject

/**
 申请退款
 
 @param refundReason 退款原因
 @param orderNum 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelRefunReason:(NSString *)refundReason orderNum:(NSString *)orderNum success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  布局UI
 */
- (void)layerUI:(NSArray *)refundApplyViewModel;
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
 <#Description#>

 @return <#return value description#>
 */
- (NSArray *)refundReason;

@end
