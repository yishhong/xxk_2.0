//
//  UIAlertController+Camera.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIAlertController (Camera)

/**
 0 为相机 1 为相册

 @param block 回调
 @return <#return value description#>
 */
+ (instancetype)selectCameraOrPhotoBlock:(void(^)(NSInteger index))block;

@end
