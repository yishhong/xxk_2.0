//
//  HBPhotoCollectionPreviewController.h
//  HotelBusiness
//
//  Created by Apricot on 16/8/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"

@interface QMPhotoCollectionPreviewController : VPBaseViewController

+ (instancetype)instantiation;

/**
 *  当前选中的图片索引
 */
@property (nonatomic) NSInteger selectedIndex;

/**
 *  获取图片总数
 */
@property (nonatomic, copy) NSInteger (^totalCount)();

/**
 *  返回指定index的图片对象
 */
@property (nonatomic, copy) id (^imageForIndex)(NSInteger index);

/**
 *  删除某张图片时，回调该方法
 */
@property (nonatomic, copy) void (^removeImageAtIndex)(NSInteger index);

@end
