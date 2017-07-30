//
//  VPTiketRefundDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTiketRefundDetailModel : VPBaseModel

/**
 订单号
 */
@property(strong, nonatomic) NSString *orderNum;

/**
 退款状态
 */
@property(assign, nonatomic) NSInteger refundState;

/**
 退款原因
 */
@property (strong, nonatomic) NSString *refundReason;

/**
 支付时间
 */
@property (strong, nonatomic) NSString *applyDate;

/**
 金额
 */
@property (assign, nonatomic) double refundMoney;

/**
 结束时间
 */
@property (strong, nonatomic) NSString *refundEndDate;


@end
