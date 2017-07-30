//
//  VPTicketListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTicketListModel : VPBaseModel

/**
 活动类型（0 报名不填资料 1 填资料支付 2 填资料不支付）
 */
@property (assign, nonatomic) NSInteger actType;
/**
 总限制人数(为0时报名人数不限)
 */
@property (assign, nonatomic) NSInteger limitPersonNum;

/**
 票类型(0当日票 1 有效期票[根据此状态来判断无时间限定类型活动] )
 */
@property (assign, nonatomic) NSInteger billType;

/**
 限购票数(0 表示不限购)
 */
@property (assign, nonatomic) NSInteger purchaseNum;

/**
 是否需要填写名字
 */
@property (assign, nonatomic) NSInteger needName;

/**
 是否需要填写电话号码
 */
@property (assign, nonatomic) NSInteger needPhone;

/**
 是否需要能填写身份证（1需要 0不需要）
 */
@property (assign, nonatomic) NSInteger needID;

/**
 是否需要填写地址
 */
@property (assign, nonatomic) NSInteger needAddress;

/**
 是否自定义
 */
@property (assign, nonatomic) NSInteger needOther;

/**
 当天开始日期
 */
@property (strong, nonatomic) NSString * billBeginDate;

/**
 当天结束日期
 */
@property (strong, nonatomic) NSString * billEndDate;


/**
 乡村id
 */
@property (strong, nonatomic) NSString * viliageId;

/**
 订单号
 */
@property (strong, nonatomic) NSString * orderNum;

/**
 评论数
 */
@property (assign, nonatomic) NSInteger commentNum;

/**
 门票ID
 */
@property (assign, nonatomic) NSInteger pid;

/**
 省ID
 */
@property (assign, nonatomic) NSInteger provinceID;

/**
 城市ID
 */
@property (assign, nonatomic) NSInteger cityID;

/**
 门票名
 */
@property (strong, nonatomic) NSString * title;

/**
 活动开始时间
 */
@property (strong, nonatomic) NSString * actBeginDate;

/**
 活动结束时间
 */
@property (strong, nonatomic) NSString * actEndDate;

/**
 报名截止日期
 */
@property (strong, nonatomic) NSString * regEndDate;

/**
 图片
 */
@property (strong, nonatomic) NSString * photoUrl;

/**
 地址
 */
@property (strong, nonatomic) NSString * actAddress;

/**
 手机号码
 */
@property (strong, nonatomic) NSString * phoneNum;

/**
 内容
 */
@property (strong, nonatomic) NSString * contentsText;

/**
 详情图片
 */
@property (strong, nonatomic) NSString * detailPicture;

/**
 是否推荐
 */
@property (assign, nonatomic) NSInteger isSuggest;

/**
 跟团游
 */
@property (nonatomic, strong) NSString *keyWord;

@property (nonatomic, strong) NSString *auditReason;
@property (nonatomic, assign) NSInteger hotSort;

@property (nonatomic, strong) NSString * info;

/**
 价格
 */
@property (nonatomic, strong) NSString *regCost;
@property (nonatomic, strong) NSString *hotSortDate;
@property (nonatomic, assign) NSInteger clubID;
@property (nonatomic, assign) NSInteger isCarousel;
@property (nonatomic, strong) NSString *bannerPhotoUrl;
@property (nonatomic, assign) NSInteger isTopWeb;
@property (nonatomic, assign) NSInteger topSortWeb;
@property (nonatomic, strong) NSString *otherName;
@property (nonatomic, assign) NSInteger shareNum;
@property (nonatomic, assign) NSInteger isShowPastAct;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *homePicture;
@property (nonatomic, strong) NSString *editTime;
@property (nonatomic, assign) NSInteger activityType;
@property (nonatomic, assign) NSInteger registNum;
@property (nonatomic, assign) NSInteger pastActSort;
@property (nonatomic, assign) NSInteger viewNum;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, assign) NSInteger auditState;
@property (nonatomic, assign) NSInteger mainType;
@property (nonatomic, assign) NSInteger topSort;


@end
