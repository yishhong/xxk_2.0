//
//  VPLstSpecialModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPLstSpecialModel : VPBaseModel


/**
 标题
 */
@property(strong, nonatomic)NSString * title;


/**
 内容
 */
@property (strong ,nonatomic) NSString *textContents;


/**
 图片
 */
@property (strong, nonatomic) NSString *photoUrl;


@end
