//
//  VPTagModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPTagModel : VPBaseModel


/**
 标签吗名
 */
@property(strong, nonatomic) NSString *tagName;


/**
 标签颜色
 */
@property(strong, nonatomic) NSString *color;


/**
 标签id
 */
@property(strong, nonatomic) NSString *tagId;

/**
 标签图片
 */
@property(strong, nonatomic) NSString *tagImage;

@end
