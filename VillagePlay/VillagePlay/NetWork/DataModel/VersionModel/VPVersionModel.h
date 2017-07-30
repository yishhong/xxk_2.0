//
//  VPVersionModel.h
//  VillagePlay
//
//  Created by Apricot on 2017/1/14.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPVersionModel : VPBaseModel
/*
 "editionNum": "16",
 "downloadUrl": "",
 "state": "1",
 "description": "",
 "isForced": "1"
 */

/**
 最新的版本号
 */
@property (nonatomic, assign) NSInteger editionNum;

/**
 下载地址
 */
@property (nonatomic, copy) NSString * downloadUrl;

/**
 状态 0不需要更新 1需要更新
 */
@property (nonatomic, assign) NSInteger state;

/**
 更新简介
 */
@property (nonatomic, copy) NSString * desc;

/**
 是否强制更新 0为不强制 1为强制
 */
@property (nonatomic, assign) BOOL isForced;
@end
