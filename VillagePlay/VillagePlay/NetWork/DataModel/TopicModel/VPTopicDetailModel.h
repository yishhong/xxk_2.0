//
//  TopicDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicVillageModel.h"
#import "VPActiveModel.h"
#import "VPCommentaryModel.h"

@interface VPTopicDetailModel : NSObject
/**
 *  专题ID
 */
@property(nonatomic,strong)NSString *projectID;
/**
 *  专题名称
 */
@property(nonatomic,strong)NSString * projectName;

/**
 *  专题简介
 */
@property(nonatomic,strong)NSString *desc;

/**
 *  图片地址
 */
@property(nonatomic,strong)NSString*photoUrl;
/**
 *  大咖ID（用户id）
 */
@property(nonatomic,strong)NSString *masterID;
/**
 *  大咖简介
 */
@property(nonatomic,strong)NSString *masterDescription;
/**
 *  专题类型
 */
@property(nonatomic,strong)NSString *pType;
/**
 *  大咖头像地址
 */
@property(nonatomic,strong)NSString *userHeadPhoto;
/**
 *  大咖姓名
 */
@property(nonatomic,strong)NSString *masterName;

/**
 *  评论数
 */
@property(nonatomic,strong)NSString * commendNum;

/**
 *  喜欢数
 */
@property(nonatomic,strong)NSString *praiseNum;

/**
 *  是否喜欢
 */
@property(nonatomic,strong)NSString *isPraise ;

/**
 *  详情
 */
@property(nonatomic,strong)NSArray *lstDesc;
/**
 *  评论集合
 */
@property(nonatomic,strong)NSArray* commentary;
/**
 *  相关村庄推荐
 */
@property(nonatomic,strong)NSArray*lstVillage;
/**
 *  相关活动推荐
 */
@property(nonatomic,strong)NSArray*lstActivity;
/**
 *  礼物列表
 */
//@property(nonatomic,strong)NSArray*lstTopicGift;

/**
 *  专题详情H5
 */
@property(nonatomic,strong)NSString*projecturl;

@end
