//
//  VPHotelRoomListRoom.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPImgListModel.h"
#import "VPFacilityListModel.h"

@interface VPHotelRoomListRoomModel : NSObject


/**
  规则id
 */
@property (nonatomic, assign) NSInteger ruleId;

/**
 判断是否可已预订
 */
@property (nonatomic, strong) NSString *isReserveRoom;

/**
 图片数组
 */
@property (nonatomic, strong) NSArray *imgUrlArray;

/**
 图片
 */
@property (nonatomic, strong) NSString *imgUrl;

/**
 房间ID
 */
@property (nonatomic, assign) NSInteger rid;

/**
 面积
 */
@property (nonatomic, strong) NSString *area;

/**
 价格
 */
@property (nonatomic, assign) float price;

/**
 床上
 */
@property (nonatomic, strong) NSString *bedNum;

/**
 房间状态
 */
@property (nonatomic, assign) NSInteger roomState;

/**
 民宿设备
 */
@property (nonatomic, strong) NSArray *infrastructure;

/**
 房间数
 */
@property (nonatomic, strong) NSString *roomnum;

/**
 房间名
 */
@property (nonatomic, strong) NSString *name;

/**
 床型
 */
@property (nonatomic, strong) NSString *bed;

@end
