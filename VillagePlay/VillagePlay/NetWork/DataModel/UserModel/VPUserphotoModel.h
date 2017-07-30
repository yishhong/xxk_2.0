//
//  VPUserphotoModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPUserphotoModel : VPBaseModel

/**
 *  图片标识
 */
@property (nonatomic, strong) NSString *pid;

/**
 *  图网址
 */
@property (nonatomic, strong) NSString *photoUrl;

/**
 *  大图网址
 */
@property (nonatomic, strong) NSString *bigphotoUrl;

@end
