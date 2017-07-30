//
//  VPBannerModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "CommentDetaileEnum.h"
@interface VPBannerInfoModel : VPBaseModel

/**
 详细地址
 */
@property (nonatomic, strong) NSString *detailUrl;

/**
 类型( 2 活动 or 1 游玩 or 0 村庄 3 新闻 4 链接地址)
 */
@property (nonatomic, strong) NSString *typeId;

/**
 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 Banner图片
 */
@property (nonatomic, strong) NSString *imageUrl;

/**
 村庄 游玩 活动 id
 */
@property (nonatomic, strong) NSString *vid;

/**
 是否推荐
 */
@property (nonatomic, strong) NSString *isSuggest;

/**
 渠道ID
 */
@property (nonatomic, assign) VPChannelType channelId;

@end
