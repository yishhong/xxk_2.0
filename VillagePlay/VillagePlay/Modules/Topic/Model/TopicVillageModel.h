//
//  TopicVillageModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicVillageModel : NSObject

/**
 *  推荐村id
 */
@property(nonatomic,strong)NSString * vid;
/**
 *  村名
 */
@property(nonatomic,strong)NSString * name ;
/**
 *  简介
 */
@property(nonatomic,strong)NSString *  desc;
/**
 *  地址
 */
@property(nonatomic,strong)NSString * address;

@end
