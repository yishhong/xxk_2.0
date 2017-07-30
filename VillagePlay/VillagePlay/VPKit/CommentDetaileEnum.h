//
//  CommentDetaileEnum.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#ifndef CommentDetaileEnum_h
#define CommentDetaileEnum_h
//SourceDetail已过期 由VPChannelType枚举代替
///**
// *  数据的来源枚举 比如直播，乡村...
// */
//typedef enum:NSInteger{
//    
//    SourceTravelDetail=0,
//    SourceLiveDetail = 1,
//    SourceVillageDetail =2,
//    
//}SourceDetail;

/* 后台的定义好的 通过api/Channel/GetChannel查询
 "村庄": 1,
 "农庄": 2,
 "旅游活动": 3,
 "民宿": 4,
 "门票": 5,
 "专题": 6,
 "直播": 7, 
 "微刊": 8,
 "精选玩法": 9
 */
typedef enum : NSUInteger {
    VPChannelTypeGift        =   -1023 ,//注意这个是自己实现的 主要用于APP分享的地方
    VPChannelTypeAPP         =   -1024 ,//注意这个是自己实现的 并非后台的(目前用在APP分享的地方)
    VPChannelTypeVillage     =   1 ,//村庄
    VPChannelTypeGrange      =   2 ,//农庄 原本老版本数据
    VPChannelTypeTravel      =   3 ,//旅游
    VPChannelTypeHotel       =   4 ,//民宿
    VPChannelTypeTicket      =   5 ,//门票
    VPChannelTypeTopic       =   6 ,//专题
    VPChannelTypeLive        =   7 ,//直播
    VPChannelTypeMagazine    =   8 ,//微刊
    VPChannelTypePlay        =   9 ,//玩法
    VPChannelTypeNews        =   10,//新闻
} VPChannelType;

/*
 优惠券的状态
 */
typedef enum : NSUInteger {
    CouponUseStateUnuse     =   0,//未使用
    CouponUseStateFreeze    =   1,//已冻结
    CouponUseStateOverdue   =   2,//已过期
    CouponUseStateUse       =   3,//已使用
} CouponUseState;

#endif /* CommentDetaileEnum_h */
