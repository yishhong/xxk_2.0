//
//  VPHotelDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPFacilityListModel.h"
#import "VPImgListModel.h"

@interface VPHotelDetailModel : NSObject

@property (nonatomic, assign) NSInteger refPrice;

/**
 内容
 */
@property (nonatomic, strong) NSString *content;

/**
 设备id
 */
@property (nonatomic, assign) NSInteger sysUserID;
@property (nonatomic, strong) NSString *province;

/**
 离店时间
 */
@property (nonatomic, strong) NSString *outTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL status;

/**
 设备数组
 */
@property (nonatomic, strong) NSArray *facilityList;

/**
 入住时间
 */
@property (nonatomic, strong) NSString *checkTime;
@property (nonatomic, assign) BOOL isShow;

/**
 经度
 */
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) BOOL isOpenMsg;

/**
 城市
 */
@property (nonatomic, strong) NSString *city;

/**
 订单号
 */
@property (nonatomic, assign) NSInteger orderNum;

/**
 id
 */
@property (nonatomic, assign) NSInteger bodyIdentifier;

/**
 图片数组
 */
@property (nonatomic, strong) NSArray *imgList;

@property (nonatomic, strong) NSString *closedInfo;

/**
 图片
 */
@property (nonatomic, strong) NSString *imgUrl;

/**
 下单时间
 */
@property (nonatomic, strong) NSString *updteDate;

/**
 面积
 */
@property (nonatomic, strong) NSString *area;

/**
 经纬度
 */
@property (nonatomic, assign) double lat;

/**
 评星
 */
@property (nonatomic, assign) NSInteger taxRate;

/**
 时间
 */
@property (nonatomic, strong) NSString *creatDate;

/**
 地址
 */
@property (nonatomic, strong) NSString *address;


@end
