//
//  ActiveModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPActiveModel : NSObject

/**
 *  活动id
 */
@property (nonatomic, copy) NSString *vid;

/**
 *  活动名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  地址
 */
@property (nonatomic, copy) NSString*address;

/**
 城市
 */
@property (nonatomic, copy) NSString *city;

/**
 *  经纬度
 */
@property (nonatomic, copy) NSString *location;

/**
 *  图片
 */
@property (nonatomic, copy) NSString *image;

/**
 *  活动结束时间
 */
@property (nonatomic, copy) NSString *activeDateTime;

/**
 *  活动开始时间
 */
@property (nonatomic,copy)NSString *activeBeginTime;

/**
 *  报名人数
 */
@property (nonatomic,copy)NSString *registrationCount;

/**
 *  是否推荐(1为推荐)
 */
@property (nonatomic,copy)NSString *isSuggest;

/**
 *  费用
 */
@property (nonatomic,copy)NSString *costs;

/**
 *  状态(0 正在报名 1 报名已满 2 报名结束)
 */
@property (nonatomic, assign)NSInteger state;

/**
 订单
 */
@property (nonatomic, assign) NSInteger actType;

/**
 跟团游
 */
@property (nonatomic, strong) NSString *keyword;

@end
