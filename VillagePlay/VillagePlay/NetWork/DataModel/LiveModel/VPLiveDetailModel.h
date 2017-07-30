//
//  VPLiveDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPLiveDetailModel : VPBaseModel

/**
 主键id
 */
@property(assign, nonatomic) NSInteger pid;

/**
 直播ID
 */
@property(assign, nonatomic) NSInteger liveID;

/**
 内容
 */
@property(strong, nonatomic)NSString *contentsText;

/**
 图片
 */
@property(strong, nonatomic)NSString *photoUrl;

/**
 时间
 */
@property(strong, nonatomic)NSString *addTime;


@end
