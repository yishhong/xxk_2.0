//
//  VPTiketOrderListOrderModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTiketOrderListOrderModel : VPBaseModel

/**
 主键ID
 */
@property(assign, nonatomic) NSInteger ceID;

/**
 门票ID
 */
@property (strong, nonatomic) NSString * ticketId;

/**
 门票名
 */
@property (strong, nonatomic) NSString * ticketName;

/**
 订单号
 */
@property (strong, nonatomic) NSString *orderNum;

/**
 参见时间
 */
@property (strong, nonatomic) NSString *joinDate;

/**
 活动图片
 */
@property (strong, nonatomic) NSString *homePicture;

/**
 活动名
 */
@property (strong, nonatomic) NSString *activitieName;

/**
 时间
 */
@property (strong, nonatomic) NSString *playTime;

/**
 退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
 */
@property(assign, nonatomic) NSInteger refundState;

/**
 支付时间
 */
@property (strong, nonatomic) NSString *applyDate;

/**
 票类型(0当日票 1 有效期票[根据此状态来判断无时间限定类型活动] )
 */
@property(assign, nonatomic) NSInteger billType;

/**
 有效期开始时间
 */
@property (strong, nonatomic) NSString *billBeginDate;

/**
 有效期结束时间
 */
@property (strong, nonatomic) NSString *billEndDate;

@property (strong, nonatomic) NSString *registDate;

/**
 订单状态
 */
@property (assign, nonatomic) NSInteger orderStatus;

/**
 总价
 */
@property (assign, nonatomic) double price;

/**
 优惠金额
 */
@property (assign, nonatomic) double discountMoney;

/**
 实付款
 */
@property (assign, nonatomic) double rechargeMoney;


/**
 购买数量
 */
@property (assign, nonatomic) NSInteger ticketCount;



@end
