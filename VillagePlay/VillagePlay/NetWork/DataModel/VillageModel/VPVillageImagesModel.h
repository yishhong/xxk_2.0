//
//  VPVillageImagesModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPVillageImagesModel : VPBaseModel


/**
 图片
 */
@property(strong, nonatomic)NSString *imageUrl;

/**
 大图
 */
@property(strong, nonatomic)NSString *bigimageUrl;

/**
 标题
 */
@property(strong, nonatomic)NSString *title;


/**
 说明
 */
@property(strong, nonatomic)NSString *desc;


@end
