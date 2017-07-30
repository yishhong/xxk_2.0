//
//  VPActiveDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPCommentaryModel.h"
#import "VPActivityDateModel.h"
#import "VPActivityGoodsModel.h"
#import "VPBusinessClubInfoModel.h"
#import "VPBaseModel.h"

@interface VPActiveDetailModel :VPBaseModel

/**
 活动id
 */
@property (nonatomic, strong) NSString *vid;

/**
 活动图片
 */
@property (nonatomic, strong) NSURL *imageUrl;

/**
 活动名称
 */
@property (nonatomic, strong) NSString *title;

/**
 费用
 */
@property (nonatomic, strong) NSString *costs;

/**
 活动地点经纬度
 */
@property (nonatomic, strong) NSString *location;

/**
 地址
 */
@property (nonatomic, strong) NSString *address;

/**
 活动详情
 */
@property (nonatomic, strong) NSString *activityInfo;

/**
 活动电话
 */
@property (nonatomic,strong)NSString *phoneNumber;

/**
 活动结束时间
 */
@property (nonatomic, strong) NSString *dateTime;

/**
 活动开始时间
 */
@property (nonatomic, strong) NSString *activeBeginTime;

/**
 报名截止日期
 */
@property (nonatomic,strong)NSString *registerEndDate;

/**
 报名人数
 */
@property (nonatomic,strong)NSString *registrationCount;

/**
 *  是否报名(-1未报名 0未付款 1已付款 2已取消)
 */
@property (nonatomic, copy) NSString *ifSignUp;

/**
 评论数
 */
@property(copy, nonatomic) NSString *commendNum;

/**
 是否推荐
 */
@property (nonatomic, strong) NSString *isSuggest;

/**
 活动类型（0 报名不填资料 1 填资料支付 2 填资料不支付）
 */
@property (nonatomic, strong) NSString *actType;

/**
 状态(0 正在报名 1 报名已满 2 报名结束)
 */
@property (nonatomic, assign) NSInteger state;

/**
 总限制人数(为0时报名人数不限)
 */
@property(assign, nonatomic) NSInteger limitPersonNum;

/**
 是否需要姓名
 */
@property(assign, nonatomic) NSInteger needName;

/**
 是否需要电话
 */
@property(assign, nonatomic) NSInteger needPhone;

/**
 是否需要身份证
 */
@property(assign, nonatomic) NSInteger needID;

/**
 是否需要地址
 */
@property(assign, nonatomic) NSInteger needAddress;

/**
 是否需要自定义
 */
@property(assign, nonatomic) NSInteger needOther;

/**
 其他
 */
@property(strong, nonatomic) NSString *otherName;

/**
 活动详情地址
 */
@property(strong, nonatomic) NSString *detailUrl;

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
 订单号
 */
@property(strong,nonatomic) NSString *orderNum;

/**
 俱乐部详情
 */
@property (nonatomic, strong)VPBusinessClubInfoModel *clubModel;

/**
 评论集合
 */
@property (strong,nonatomic)NSArray <VPCommentaryModel*>*commentaryModel;

/**
 获取报名时间列表
 */
@property (strong,nonatomic)NSArray <VPActivityDateModel*>*lstActivityDate;

/**
 活动商品列表
 */
@property (strong,nonatomic)NSArray <VPActivityGoodsModel *>*lstActivityGoods;


@end
