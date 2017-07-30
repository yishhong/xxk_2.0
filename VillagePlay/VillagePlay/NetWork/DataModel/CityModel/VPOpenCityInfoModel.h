//
//  VPOpenCityInfoModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPOpenCityInfoModel : VPBaseModel


/**
 城市ID
 */
@property (nonatomic, strong) NSString * vid;

/**
 城市名称
 */
@property (nonatomic, strong) NSString * cityName;

/**
 城市的首字母
 */
@property (nonatomic, strong) NSString * py;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelsct;

@end
