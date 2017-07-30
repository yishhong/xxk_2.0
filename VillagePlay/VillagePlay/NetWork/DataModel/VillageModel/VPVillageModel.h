//
//  VPVillageModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPTagModel.h"

@interface VPVillageModel : VPBaseModel

/**
 评论数
 */
@property (nonatomic, strong) NSString *commentaryCount;

/**
 村名
 */
@property (nonatomic, strong) NSString *name;

/**
 经纬度
 */
@property (nonatomic, strong) NSString *location;

/**
 地址
 */
@property(nonatomic,strong)NSString * address;

/**
 id
 */
@property (nonatomic, strong) NSString *vid;

/**
 图片
 */
@property (nonatomic, strong) NSString *image;

/**
 标签集
 */
@property (nonatomic, strong) NSArray <VPTagModel *>*tags;

/**
 简介
 */
@property (nonatomic, strong) NSString *desc;


- (NSString *)distance;


@end
