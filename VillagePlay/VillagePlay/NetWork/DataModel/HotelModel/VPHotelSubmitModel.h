//
//  VPHotelSubmitModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPHotelSubmitModel : NSObject

/**
 订单ID
 */
@property (strong, nonatomic) NSString *orderId;

/**
 用户ID
 */
@property (strong, nonatomic) NSString * userId;

/**
 民宿ID
 */
@property (assign, nonatomic) NSInteger hid;

/**
 房间数量
 */
@property (strong, nonatomic) NSString * quantity;

/**
 房间ID
 */
@property (assign, nonatomic) NSInteger roomId;

/**
 支付类型
 */
@property (strong, nonatomic) NSString *payType;

/**
 订单状态
 */
@property (assign, nonatomic) NSInteger orderState;

/**
 订单时间
 */
@property (strong, nonatomic) NSString *orderDate;

/**
 开始时间
 */
@property (strong, nonatomic) NSString *beginDate;

/**
 结束时间
 */
@property (strong, nonatomic) NSString *endDate;

/**
 总价
 */
@property (assign, nonatomic) double payMoney;

/**
 入住人数
 */
@property (strong, nonatomic) NSString * checkPersonNum;

/**
 预定人姓名
 */
@property (strong, nonatomic) NSString *linkRealName;

/**
 预订单手机号码
 */
@property (strong, nonatomic) NSString *linkPhone;

/**
 订单说明
 */
@property (strong, nonatomic) NSString *orderDesc;

/**
 房间信息
 */
@property (strong, nonatomic) NSString *roomInfo;

/**
 优惠码
 */
@property (strong, nonatomic) NSString *couponCode;

/**
 实付款
 */
@property (assign, nonatomic) double actualPayment;



//以下数据为项目中使用需要的
/**
 单价
 */
@property (assign, nonatomic) double unitPrice;

/**
 优惠的金额
 */
@property (assign, nonatomic) double preferentialAmount;

@end
