//
//  VPTravelSubitLstGoods.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/6.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTravelSubitLstGoods : VPBaseModel

/**
 商品ID
 */
@property(strong,nonatomic)NSString *goodsID;

/**
 个数
 */
@property(strong,nonatomic)NSString *number;

/**
 对应人数
 */
@property(strong,nonatomic)NSString *corPersonNum;

/**
 商品名称
 */
@property(strong,nonatomic)NSString *goodsName;

@end
