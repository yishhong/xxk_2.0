//
//  VPTicketSubitInformationModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPTravelSubitLstGoods.h"

@interface VPTicketSubitInformationModel : VPBaseModel

/**
 姓名
 */
@property(strong, nonatomic) NSString *realName;

/**
 电话号码
 */
@property(strong, nonatomic) NSString *phoneNumberpe;

/**
 门票类别ID
 */
@property (strong, nonatomic) NSString * activitiesId;

/**
 用户ID
 */
@property (strong, nonatomic) NSString * userId;

/**
 时间
 */
@property (strong, nonatomic) NSString * joinDate;

/**
 身份证
 */
@property (strong, nonatomic) NSString * idCord;

/**
 总价
 */
@property (assign, nonatomic) double totalRealPrice;

/**
 商品
 */
@property (strong, nonatomic) NSArray <VPTravelSubitLstGoods *>* lstGoods;

/**
 优惠券号
 */
@property (strong, nonatomic) NSString * couponCode;

/**
 渠道ID
 */
@property (assign, nonatomic) NSInteger channelId;

/**
 实际付款
 */
@property (assign, nonatomic) double actualPayment;

/**
 优惠金额
 */
@property (assign, nonatomic) double discount;

@property (strong, nonatomic) NSString *JoinDateStr;

@end
