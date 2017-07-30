//
//  VPTravelOrdersListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTravelOrdersListModel : VPBaseModel
/**
 主键ID
 */
@property(strong,nonatomic)NSString * ceID;

/**
 活动ID
 */
@property (strong, nonatomic) NSString * activeId;

/**
 订单号
 */
@property(strong,nonatomic)NSString *orderNum;

/**
 参与时间
 */
@property(strong,nonatomic)NSString *joinDate;

/**
 图片
 */
@property(strong,nonatomic)NSString *homePicture;

/**
 活动名称
 */
@property(strong,nonatomic)NSString *activitieName;

/**
 时间段
 */
@property(strong,nonatomic)NSString *playTime;

/**
 退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
 */
@property(assign,nonatomic)NSInteger refundState;

/**
 申请时间【用于退款单】
 */
@property(strong,nonatomic)NSString *applyDate;

/**
 票类型(0当日票 1 有效期票[根据此状态来判断无时间限定类型活动] )
 */
@property(assign, nonatomic) NSInteger billType;

/**
 有效期开始时间
 */
@property(strong, nonatomic) NSString *billBeginDate;

/**
 有效期结束时间
 */
@property(strong, nonatomic) NSString *billEndDate;

/**
 价格
 */
@property (assign, nonatomic) float totalRealPrice;

/**
 商品数
 */
@property (strong ,nonatomic) NSString * goodsCount;

/**
 优惠金额
 */
@property (assign, nonatomic) double discountMoney;

/**
 实付款
 */
@property (assign, nonatomic) double rechargeMoney;

@end
