//
//  VPTiketOrderDetailOrderModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPTiketOrderListOrderModel.h"

@interface VPTicketGoods : VPBaseModel

@property(strong, nonatomic) NSString *title;

@property(strong, nonatomic) NSString *goodsName;

@property(assign, nonatomic) NSInteger goodsNum;

@property(assign, nonatomic) double presentPrice;

@end

@interface VPTicketRegisteRecord : VPBaseModel

/**
 门票名
 */
@property(strong, nonatomic) NSString * ticketName;

/**
 门票ID
 */
@property(assign, nonatomic) NSInteger ticketId;

/**
 订单号
 */
@property(strong, nonatomic) NSString * orderNum;

/**
 状态
 */
@property(assign, nonatomic) NSInteger isAccept;

/**
 实付价
 */
@property(assign, nonatomic) double rechargeMoney;

/**
 优惠金额
 */
@property(assign, nonatomic) double discountMoney;

/**
 支付方式
 */
@property(assign, nonatomic) double paymentMethod;

/**
 时间
 */
@property(strong, nonatomic) NSString * rechargeDate;

/**
 预定人姓名
 */
@property(strong, nonatomic) NSString * ceName;

/**
 预订人手机号
 */
@property(strong, nonatomic) NSString * phoneNumber;

/**
 退款状态
 */
@property (assign, nonatomic) NSInteger refundState;


@end

@interface VPTiketOrderDetailOrderModel : VPBaseModel

@property (strong, nonatomic) NSArray <VPTicketRegisteRecord *>*ticketRegisteRecord;

@property (strong, nonatomic) NSArray <VPTicketGoods *>*ticketGoods;

@end
