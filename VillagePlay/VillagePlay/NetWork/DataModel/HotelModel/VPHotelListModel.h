//
//  VPHotelListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPHotelListModel : NSObject


/**
 民宿ID
 */
@property(assign, nonatomic) NSInteger hid;


/**
  民宿名
 */
@property(strong, nonatomic) NSString *name;


/**
 民宿地址
 */
@property(strong, nonatomic) NSString *address;


/**
 纬度
 */
@property(assign, nonatomic) NSInteger latitude;


/**
 经度
 */
@property(assign, nonatomic) NSInteger longitude;

/**
 图片
 */
@property(strong, nonatomic) NSString *imgUrl;

/**
 价格
 */
@property(assign, nonatomic) double price;

/**
 民宿设施
 */
@property(strong, nonatomic) NSString *facilityList;

@property(strong, nonatomic) NSString *imgUrlArray;

/**
 距离
 */
@property(strong, nonatomic) NSString *juli;



@end
