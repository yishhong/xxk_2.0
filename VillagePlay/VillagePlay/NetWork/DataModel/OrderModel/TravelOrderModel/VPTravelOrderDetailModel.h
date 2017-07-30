//
//  VPTravelOrderDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPTravelSubitLstGoods.h"

@interface VPTravelOrderDetailModel : VPBaseModel

/**
 姓名
 */
@property(strong,nonatomic)NSString *cEName;


/**
 手机号码
 */
@property(strong,nonatomic)NSString *phoneNumber;


/**
 身份证
 */
@property(strong,nonatomic)NSString *idCord;


/**
 地址
 */
@property(strong,nonatomic)NSString *address;


/**
 自定义
 */
@property(strong,nonatomic)NSString *custom;

/**
 总原价
 */
@property(assign,nonatomic)float totalOriginal;

/**
 总实价
 */
@property(assign,nonatomic)float totalRealPrice;


/**
 报名时间
 */
@property(strong,nonatomic)NSString *registDate;

/**
 支付方式
 */
@property(assign,nonatomic)NSInteger paymentMethod;

/**
  付款状态 0待付款,1待出行,4已完成,2已取消,3已退款
 */
@property(assign,nonatomic)NSInteger isAccept;

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
 退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】

 */
@property (assign, nonatomic)NSInteger refundState;

/**
 商品列表【见活动报名】
 */
@property(strong,nonatomic)NSArray <VPTravelSubitLstGoods *>*lstGoods;

/**
 订单ID
 */
@property (assign, nonatomic)NSInteger ceID;

/**
 订单号
 */
@property (strong, nonatomic)NSString *orderNum;

/**
 参加时间
 */
@property (strong, nonatomic)NSString * joinDate;

/**
 图片
 */
@property (strong, nonatomic)NSString * homePicture;

/**
 活动名
 */
@property (strong, nonatomic)NSString * activitieName;

/**
 <#Description#>
 */
@property (strong, nonatomic)NSString * playTime;

/**
 支付时间
 */
@property (strong, nonatomic)NSString * applyDate;

/**
 商品数量
 */
@property (assign, nonatomic)NSInteger goodsCount;

/**
 旅游ID
 */
@property (strong, nonatomic) NSString * activeId;

/**
 优惠金额
 */
@property (assign, nonatomic) double discountMoney;

/**
 实付款
 */
@property (assign, nonatomic) double rechargeMoney;

@end
