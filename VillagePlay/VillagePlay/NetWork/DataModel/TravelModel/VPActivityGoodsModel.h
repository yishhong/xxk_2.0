//
//  VPActivityGoodsModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPBaseModel.h"


@interface VPActivityGoodsModel : VPBaseModel

/**
 门票ID
 */
@property (nonatomic, assign) NSInteger pid;

/**
 活动ID
 */
@property (nonatomic, assign) double activitieID;

//商品ID
@property(nonatomic)NSInteger goodsID;

//商品名
@property(nonatomic,strong)NSString* goodsName;

//原价
@property(nonatomic)double originalPrice;

//现价
@property(nonatomic)double presentPrice;

//对应人数
@property(nonatomic, copy) NSString *corPersonNum;

// 限购票数(0 表示不限购)
@property(assign, nonatomic) NSInteger purchaseNum;

@property(assign, nonatomic) NSInteger buyNum;

/**
 选择的票数
 */
@property (strong, nonatomic) NSNumber * selectedNum;

/**
 状态区分 0 可删除(代表添加过来的) 1不可删除 2未添加
 */
@property (assign, nonatomic) NSInteger type;
@end
