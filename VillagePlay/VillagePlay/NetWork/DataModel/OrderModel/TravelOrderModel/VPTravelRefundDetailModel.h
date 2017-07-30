//
//  VPTravelRefundDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTravelRefundDetailModel : VPBaseModel

@property(assign, nonatomic) NSInteger activeId;

@property(assign, nonatomic) NSInteger ceID;

@property(assign, nonatomic) NSInteger pid;

@property(strong, nonatomic) NSString * orderNum;

/**
 参加时间
 */
@property(strong, nonatomic) NSString * joinDate;

@property(strong, nonatomic) NSString * homePicture;

@property(strong, nonatomic) NSString * activitieName;

/**
 <#Description#>
 */
@property(strong, nonatomic) NSString * playTime;

/**
 申请状态
 */
@property(assign, nonatomic) NSInteger refundState;

/**
 申请时间
 */
@property(strong, nonatomic) NSString * applyDate;

/**
 报名开始时间
 */
@property(strong, nonatomic) NSString * billBeginDate;

/**
 报名结束时间
 */
@property(strong, nonatomic) NSString * billEndDate;

/**
 总价
 */
@property(assign, nonatomic) double totalRealPrice;

/**
 实付款
 */
@property(assign, nonatomic) double rechargeMoney;

/**
 优惠金额
 */
@property(assign, nonatomic) double discountMoney;

/**
 购买数量
 */
@property(assign, nonatomic) NSInteger goodsCount;


@end
