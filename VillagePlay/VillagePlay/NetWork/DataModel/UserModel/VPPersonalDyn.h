//
//  VPPersonalDyn.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPPhotoUrls.h"

@interface VPPersonalDyn : VPBaseModel

/**
 *  图
 */
@property (nonatomic, strong) NSArray *photoUrls;
/**
 *  时间
 */
@property (nonatomic, strong) NSString *createdate;
/**
 *  小图
 */
@property (nonatomic, strong) NSString * smallHeadPhoto;
/**
 *  评论列表
 */
@property (nonatomic, strong) NSArray * commentaryModel;
/**
 *  年龄
 */
@property (nonatomic, strong) NSString * age;
/**
 *  赞
 */
@property (nonatomic, strong) NSString * praiseNum;
/**
 *  报名人所有图像集合
 */
@property (nonatomic, strong) NSArray * praiseModel;
/**
 *  性别
 */
@property (nonatomic, strong) NSString * sex;
/**
 *  头像
 */
@property (nonatomic, strong) NSString * headphoto;
/**
 *  评论数
 */
@property (nonatomic, assign) NSInteger commentNum;
/**
 *  用户ID
 */
@property (nonatomic, strong) NSString * userId;
/**
 *  是否点赞(0否 1 是)
 */
@property (nonatomic, strong) NSString * ifPraise;

/**
 *  经纬度
 */
@property (nonatomic, strong) NSString *releaseSite;

/**
 *  别名
 */
@property (nonatomic, strong) NSString * nickname;
/**
 *  个人动态ID
 */
@property (nonatomic, strong) NSString *pid;
/**
 *是否是大咖（1是）
 */
@property (nonatomic, strong) NSString * isMaster;
/**
 *  内容
 */
@property (nonatomic, strong) NSString *content;

@end
