//
//  VPUserInfoModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPPersonalDyn.h"
#import "VPUserphotoModel.h"

@interface VPUserInfoModel : VPBaseModel

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

/**
 *  定位
 */
@property (nonatomic, strong) NSString *location;

/**
 *  出生日期
 */
@property (nonatomic, strong) NSString *birthday;
/**
 *  最新一条动态
 */
@property (nonatomic, strong) VPPersonalDyn *personalDyn;
/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *  rewardNum;
/**
 *  关系 0 无 1 已关注 2 黑名单
 */
@property (nonatomic, strong) NSString *  relation;
/**
 *  用户图片
 */
@property (nonatomic, strong) NSArray *userphotoModel;
/**
 *  个人动态数量
 */
@property (nonatomic, strong) NSString *personalDynNum;
/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *vid;

/**
 *  别名
 */
@property (nonatomic, strong) NSString *nickname;

/**
 *  性别
 */
@property (nonatomic, strong) NSString *sex;

/**
 *  兴趣爱好
 */
@property (nonatomic, strong) NSString *interest;

/**
 *  个人资料背景图
 */
@property (nonatomic, strong) NSString *backphotoUrl;

/**
 *  签名
 */
@property (nonatomic, strong) NSString *signature;

/**
 *  粉丝数
 */
@property (nonatomic, strong) NSString *fansNum;

/**
 *  状态
 */
@property (nonatomic, strong) NSString * state;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *  stateMessage;

/**
 *  小图
 */
@property (nonatomic, strong) id smallHeadPhoto;

/**
 *   provinceID:省ID
 */
@property (nonatomic, strong) NSString *provinceID;

/**
 *  行业
 */
@property (nonatomic, strong) NSString *occupation;

/**
 *  关注数
 */
@property (nonatomic, strong) NSString *attentionNum;

/**
 *  背景图片
 */
@property (nonatomic, strong) NSString *backgroundImage;

/**
 *  等级
 */
@property (nonatomic, strong) NSString *level;

/**
 头像
 */
@property (nonatomic, strong) NSString *headphoto;
/**
 *  是否是朋友
 */
@property (nonatomic, strong) NSString *isFriend;

/**
 *  地址
 */
@property (nonatomic, strong) NSString *area;

/**
 年龄
 */
@property (nonatomic, strong) NSString *age;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *coins;

/**
 *  城市ID
 */
@property (nonatomic, strong) NSString *cityID;

/**
 *  大咖(1是)
 */
@property (nonatomic, strong) NSString *  isMaster;

/**
 *  简介
 */
@property (nonatomic, strong) NSString * introduction;

/**
 *  家乡
 */
@property (nonatomic, strong) NSString *  hometown;

/**
 是否接收通知
 */
@property (nonatomic, assign) BOOL isNotice;

@end
