//
//  VPPhotoUrls.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPPhotoUrls : VPBaseModel

/**
 *  标识
 */
@property (nonatomic, assign) id pid;

/**
 *  图
 */
@property (nonatomic, strong) NSString *photoUrl;

/**
 *  大图
 */
@property (nonatomic, strong) NSString *bigphotoUrl;

@end
