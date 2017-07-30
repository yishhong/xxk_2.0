//
//  VPFacilityListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPFacilityListModel : NSObject


/**
 设备id
 */
@property (assign, nonatomic) NSInteger facilityID;


/**
 设备名
 */
@property (strong ,nonatomic) NSString *title;


/**
 设备图片
 */
@property (strong, nonatomic) NSString *iconUrl;


/**
 设备类型id
 */
@property (assign, nonatomic) NSInteger facilityTypeid;


/**
 时间
 */
@property (strong, nonatomic) NSString * createDate;

@end
