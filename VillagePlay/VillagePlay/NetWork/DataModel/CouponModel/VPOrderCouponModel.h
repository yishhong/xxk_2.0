//
//  VPOrderCouponModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPOrderCouponModel : VPBaseModel

/**
 优惠券id
 */
@property (assign, nonatomic) NSInteger couponId;

@property (assign, nonatomic) NSInteger scopeId;

/**
 标题
 */
@property (strong, nonatomic) NSString * title;

/**
 优惠券类型
 */
@property (assign, nonatomic) NSInteger conponType;

/**
 优惠价格
 */
@property (assign, nonatomic) NSInteger discountMoney;

/**
 折扣数
 */
@property (assign, nonatomic) NSInteger discountValue;

/**
 0不限制 1抵扣劵  2折扣劵
 */
@property (assign, nonatomic) NSInteger discountType;

/**
 优惠码
 */
@property (strong, nonatomic) NSString * couponCode;

/**
 优惠劵状态
 */
@property (assign, nonatomic) NSInteger couponStatus;

/**
 
 */
@property (strong, nonatomic) NSString * generateTime;

/**
 订单ID
 */
@property (strong, nonatomic) NSString * orderId;

/**
 用户ID
 */
@property (assign, nonatomic) NSInteger userId;

/**
 开始时间
 */
@property (strong, nonatomic) NSString * startTime;

/**
 关闭时间
 */
@property (strong, nonatomic) NSString * closingTime;

@property (assign, nonatomic) NSInteger timeLong;

@property (strong, nonatomic) NSString *desc;

@property (assign, nonatomic) double amount;

@property (assign, nonatomic) NSInteger sentCount;

@property (assign, nonatomic) NSInteger usedCount;

@property (assign, nonatomic) NSInteger needPoint;

@property (assign, nonatomic) NSInteger validType;

@property (strong, nonatomic) NSString *usedTime;


//"couponId": 1,
//"scopeId": 4,
//"title": "民宿满100减50",
//"conponType": 1,
//"discountMoney": 50,
//"discountValue": null,
//"discountType": 1,
//"couponCode": "123456",
//"couponStatus": 0,
//"generateTime": "2016-12-07 00:00:00",
//"orderId": "",
//"userId": 12101,
//"startTime": "2016-12-07 00:00:00",
//"closingTime": "2016-12-31 00:00:00",
//"timeLong": null,
//"description": "测试",
//"amount": 99,
//"sentCount": 1,
//"usedCount": 0,
//"needPoint": null,
//"validType": 1,
//"usedTime": "2016-12-07 08:52:52"

@end
