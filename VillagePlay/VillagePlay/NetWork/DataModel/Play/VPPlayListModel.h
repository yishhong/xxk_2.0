//
//  VPPlayListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPPlayDetailModel.h"

@interface VPPlayListModel : VPBaseModel

/**
 玩法ID
 */
@property(assign, nonatomic) NSInteger fpId;

/**
 玩法介绍
 */
@property(strong, nonatomic) NSString *lineName;

/**
 玩法标题
 */
@property(strong, nonatomic) NSString *title;

/**
 玩法图片
 */
@property (strong, nonatomic) NSArray *imgs;

/**
 玩法年月日
 */
@property (strong ,nonatomic) NSArray *tagList;

/**
 时间
 */
@property(strong, nonatomic) NSString *addTime;

/**
 浏览数
 */
@property(assign, nonatomic) NSInteger shareNum;

/**
 观看数
 */
@property(assign, nonatomic) NSInteger viewNum;

/**
 评论数
 */
@property(assign, nonatomic) NSInteger commentNum;

/**
 <#Description#>
 */
@property(strong, nonatomic) NSArray <VPPlayDetailModel *>*items;


@end
