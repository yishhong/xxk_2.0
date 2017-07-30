//
//  VPVillageDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPCommentaryModel.h"
#import "VPVillageImagesModel.h"
#import "VPVillageModel.h"
#import "VPTagModel.h"
#import "VPLstSpecialModel.h"

@interface VPVillageDetailModel : VPBaseModel

/**
 村id
 */
@property(nonatomic, strong) NSString * vid ;

/**
 星级
 */
@property(nonatomic, strong) NSString *rating ;

/**
 村名
 */
@property(nonatomic, strong)NSString* name ;

/**
 描述
 */
@property(nonatomic,strong)NSString * desc ;

/**
 经纬度
 */
@property(nonatomic,strong)NSString *location ;

/**
 报名数量
 */
@property(nonatomic,strong)NSString * registerNum ;

/**
 是否报名
 */
@property(nonatomic,strong)NSString *isRegister ;

/**
 评论数量
 */
@property(nonatomic,strong)NSString *commentaryCount ;

/**
 特色 html页面
 */
@property(nonatomic,strong)NSString *characteristicURL ;

/**
 出行
 */
@property(nonatomic,strong)NSString *journeyURL;

/**
 特产
 */
@property(nonatomic,strong)NSString *specialProduct ;

/**
 村庄头部图片
 */
@property(nonatomic,strong)NSString *headImageUrl ;

/**
 标签集合
 */
@property(nonatomic,strong)NSArray <VPTagModel *>* tags ;

/**
 村庄游记列表
 */
//@property(nonatomic,strong)NSArray<TravelNotesModel> *travellst ;

/**
 评论集合
 */
@property(nonatomic,strong)NSArray <VPCommentaryModel *>*commentary ;

/**
 图集
 */
@property(nonatomic,strong)NSArray<VPVillageImagesModel*> * images ;

/**
 村庄
 */
@property(nonatomic,strong)NSArray<VPVillageModel*>*hotVillages;

/**
 村庄介绍
 */
@property(nonatomic,strong)NSArray<VPLstSpecialModel*> *lstSpecial;

/**
 点赞数
 */
@property(nonatomic,strong)NSString * praiseNum;

/**
 是否点赞
 */
@property(nonatomic,strong)NSString  * isPraise;

/**
 地址
 */
@property (nonatomic,strong) NSString *address;

/**
 出行
 */
@property (nonatomic,strong) NSString *journey;

/**
 其他线路
 */
@property (nonatomic,strong) NSString *hiking;

@end
