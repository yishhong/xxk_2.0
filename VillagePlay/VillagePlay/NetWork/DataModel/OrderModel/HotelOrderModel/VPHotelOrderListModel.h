//
//  VPHotelOrderListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPHotelOrderListModel : VPBaseModel

/**
 预订人姓名
 */
@property (nonatomic, strong) NSString *linkRealName;

/**
 支付时间
 */
@property (nonatomic, assign) NSString * payDate;

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
 <#Description#>
 */
@property (nonatomic, assign) NSString * updateDate;

/**
 民宿名
 */
@property (nonatomic, strong) NSString *hotelName;

@property (nonatomic, assign) NSString * returnCreateTime;

/**
 订单号
 */
@property (nonatomic, strong) NSString *orderNum;

/**
 房间ID
 */
@property (nonatomic, assign) NSInteger roomId;

/**
 房间名
 */
@property (nonatomic, strong) NSString *name;

/**
 房间数量
 */
@property (nonatomic, assign) NSString * roomNum;

/**
 房间类型
 */
@property (nonatomic, strong) NSString *roomType;

/**
 入住时间
 */
@property (nonatomic, strong) NSString *enterDataTime;

/**
 预订人手机号码
 */
@property (nonatomic, strong) NSString *linkPhone;

/**
 床型id
 */
@property (nonatomic, strong) NSString *bedTypeId;

/**
 价格
 */
@property (nonatomic, assign) double price;

/**
 结束时间
 */
@property (nonatomic, assign) NSString * finishDate;

/**
 民宿ID
 */
@property (nonatomic, assign) NSInteger hotelId;

/**
 房间状态(0待付款,1预订取消，2待确认，3等待入住，5已完成（已入住），6已取消退款中，7已取消退款中，8已完成未入住，9已取消已退款)
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

@end
