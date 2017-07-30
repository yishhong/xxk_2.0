//
//  VPCouponModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "CommentDetaileEnum.h"
@interface VPCouponModel : VPBaseModel

/**
 优惠券ID
 */
@property (nonatomic, assign) NSInteger couponId;

/**
 优惠券Code
 */
@property (nonatomic, strong) NSString * couponCode;


#warning 这块用在获取得到的优惠券
/**
 "couponId": 2,
 "couponCode": "BOGO50",
 "scopeId": 3,
 "title": "新用户19元无门槛券",
 "discountMoney": 10,
 "startTime": "2016-12-08 00:00:00",
 "closingTime": "2016-12-13 00:00:00"
 */

@property (nonatomic, assign) NSInteger scopeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double discountMoney;

/**
 结束时间
 */
@property (nonatomic, strong) NSString *closingTime;

/**
 开始时间
 */
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *desc;

@property (nonatomic, assign) CouponUseState xx_couponState;
#warning 一下的数据用在激活验证码 可能是无效数据

/**
 用户ID
 */
@property (nonatomic, assign) NSInteger userId;

/**
 优惠券状态
 */
@property (nonatomic, assign) NSInteger couponStatus;

/**
 发出时间
 */
@property (nonatomic, strong) NSString * generateTime;

/**
 使用时间
 */
@property (nonatomic, strong) NSString * usedTime;

/**
 订单ID
 */
@property (nonatomic, strong) NSString * orderId;

@end
