//
//  VPHotelRefundDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPHotelRefundDetailModel : VPBaseModel

@property (assign, nonatomic)NSInteger refundDetailID;

/**
 *  订单号
 */
@property (nonatomic, assign) NSInteger orderId;

/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 *  审核时间？？？
 */
@property (nonatomic, copy) NSString *configTime;

@property (nonatomic, copy) NSString *handleTime;

/**
 *  完成时间
 */
@property (nonatomic, copy) NSString *finishTime;

/**
 *  ???
 */
@property (nonatomic, assign) NSInteger status;

/**
 */
@property (nonatomic, assign) NSInteger configReturnUserId;

@property (nonatomic, assign) NSInteger configUserType;

/**
 *  退款金额
 */
@property (nonatomic, assign) double returnMoney;

/**
 *  扣款金额
 */
@property (nonatomic, assign) double returnDebitMoeny;

/**
 *  说明
 */
@property (nonatomic, copy) NSString *desc;

/**
 *  理由
 */
@property (nonatomic, copy) NSString *reason;


@end
