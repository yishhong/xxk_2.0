//
//  VPTravelTagsModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTravelTagsModel : VPBaseModel

/**
 tagID
 */
@property(assign,nonatomic)NSInteger tagID;

/**
 tag名
 */
@property(strong ,nonatomic) NSString *tagName;

/**
 tag颜色
 */
@property(strong ,nonatomic) NSString *tagColor;

/**
 排序方式
 */
@property(assign ,nonatomic) NSInteger sort;

/**
 tag图片
 */
@property(strong ,nonatomic) NSString *tagImage;

/**
 <#Description#>
 */
@property(assign ,nonatomic) NSInteger tagLevel;

/**
 省ID
 */
@property(assign ,nonatomic) NSInteger parentID;

/**
 频道ID
 */
@property(assign ,nonatomic) NSInteger channelId;

@end
