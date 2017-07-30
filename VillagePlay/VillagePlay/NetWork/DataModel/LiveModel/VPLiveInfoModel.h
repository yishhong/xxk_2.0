//
//  VPLiveInfoModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPLiveInfoModel : VPBaseModel

/**
 直播用户ID
 */
@property (nonatomic, assign) NSInteger userID;

/**
 直播状态（0：未开始  1：正在直播  2：直播结束）
 */
@property (nonatomic, assign) NSInteger liveState;

/**
 直播开始时间
 */
@property (nonatomic, copy) NSString *beginTime;

/**
 是否推荐 0.默认 1.推荐
 */
@property (nonatomic, assign) BOOL isTop;

/**
 直播员名称
 */
@property (nonatomic, copy) NSString *liveMember;

/**
 直播标题
 */
@property (nonatomic, copy) NSString *title;

/**
 列表图地址
 */
@property (nonatomic, copy) NSString *photoUrl;

/**
 直播类型 0.图文直播 1.视频直播
 */
@property (nonatomic, assign) NSInteger type;


/**
 视频直播网址
 */
@property (nonatomic, copy) NSString * videoUrl;

/**
 评论数
 */
@property (nonatomic, assign) NSUInteger commentNum;

/**
 主键ID
 */
@property (nonatomic, assign) NSInteger pid;


/**
 观看人数
 */
@property (nonatomic, assign) NSUInteger viewNum;


/**
 浏览次数
 */
@property (nonatomic, assign) NSUInteger shareNum;


/**
 村id
 */
@property (nonatomic, assign) NSInteger viliageId;

/**
 视频直播图文介绍
 */
@property (nonatomic, strong) NSString * info;



/// 直播员头像地址
//@property(strong ,nonatomic)NSString <Optional>*headPhotoUrl;

//直播H5地址
//@property(strong ,nonatomic)NSString <Optional>*liveUrl;

- (NSDictionary *)liveStateForInfo;

@end
