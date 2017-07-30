//
//  VPTravilSubitInformationModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/6.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPTravelSubitLstGoods.h"

@interface VPTravilSubitInformationModel : VPBaseModel

/**
 预订人名
 */
@property (strong, nonatomic)NSString *realName;

/**
 预订人电话号码
 */
@property (strong, nonatomic)NSString *phoneNumber;

/**
 活动id
 */
@property (strong, nonatomic)NSString *activitiesID;


/**
 用户ID
 */
@property (strong, nonatomic)NSString * userID;

/**
 参加时间
 */
@property (strong, nonatomic)NSString *joinDate;

/**
  活动类型
 */
@property (assign, nonatomic)NSString* actType;

/**
 版本号
 */
@property (strong, nonatomic)NSString *version;

/**
 成人数
 */
@property (assign, nonatomic)NSInteger adultNum;

/**
 孩子数
 */
@property (assign, nonatomic)NSInteger childNum;

/**
 支付方式
 */
@property (assign, nonatomic)NSInteger paymentMethod;

/**
 总价
 */
@property (assign, nonatomic)float totalRealPrice;

/**
 身份证
 */
@property (strong, nonatomic) NSString * idCord;

/**
 地址
 */
@property (strong, nonatomic) NSString * address;

/**
 自定义
 */
@property (strong, nonatomic) NSString * custom;

/**
 优惠券
 */
@property (strong, nonatomic) NSString *conponCode;

/**
 活动
 */
@property (strong, nonatomic)NSArray <VPTravelSubitLstGoods *> *lstGoods;

/**
 优惠后价格
 */
@property (assign, nonatomic)float actualPayment;

@end
