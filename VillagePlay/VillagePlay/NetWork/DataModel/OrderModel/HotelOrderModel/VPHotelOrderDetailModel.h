//
//  VPHotelOrderDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPHotelOrderDetailModel : VPBaseModel

/**
 地址
 */
@property (nonatomic, strong) NSString *address;

/**
 床型信息
 */
@property (nonatomic, strong) NSString *bedInfo;

/**
 预订人姓名
 */
@property (nonatomic, strong) NSString *linkRealName;

/**
 支付时间
 */
@property (nonatomic, strong) NSString * payDate;

/**
 房间图片
 */
@property (nonatomic, strong) NSString *roomImg;

/**
 离店时间
 */
@property (nonatomic, strong) NSString *outDataTime;

/**
 支付类型
 */
@property (nonatomic, strong) NSString *payType;

/**
 是否退款
 */
@property (nonatomic, strong) NSString *isRefund;

/**
 更新时间
 */
@property (nonatomic, strong) NSString * updateDate;

/**
 民宿名
 */
@property (nonatomic, strong) NSString *hotelName;

/**
 订单号
 */
@property (nonatomic, strong) NSString *orderNum;

/**
 房间id
 */
@property (nonatomic, assign) NSInteger roomId;

/**
 预订人数
 */
@property (nonatomic, assign) NSInteger checkPersonNum;

/**
 房间数
 */
@property (nonatomic, assign) NSInteger roomNum;

/**
 规则ID
 */
@property (nonatomic, assign) NSInteger ruleid;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *name;

/**
 房间类型
 */
@property (nonatomic, strong) NSString *roomType;

/**
 入住时间
 */
@property (nonatomic, strong) NSString *enterDataTime;

/**
 预订人号码
 */
@property (nonatomic, strong) NSString *linkPhone;

/**
 床型id
 */
@property (nonatomic, strong) NSString *bedTypeId;

/**
 订单时间
 */
@property (nonatomic, strong) NSString *orderDate;

@property (nonatomic, assign) NSInteger taxRate;

/**
 价格
 */
@property (nonatomic, assign) float price;

/**
 结束时间
 */
@property (nonatomic, strong) NSString * finishDate;

/**
 
 */
@property (nonatomic, assign) float returnMoney;

/**
 民宿id
 */
@property (nonatomic, assign) NSInteger hotelId;

/**
 订单状态
 */
@property (nonatomic, assign) NSInteger orderState;

/**
 优惠金额
 */
@property (assign, nonatomic) double discountMoney;

/**
 实付款
 */
@property (assign, nonatomic) double rechargeMoney;

@property (assign, nonatomic) double returnDebitMoeny;

@end
