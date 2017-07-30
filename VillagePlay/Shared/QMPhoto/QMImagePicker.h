//
//  QMImagePicker.h
//  Photo
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


/**
 选择相机的回调

 @param isSourceTypeAvailable 是否可用相机
 @param authorizationStatus 权限
 @param image 图片
 */
typedef void(^ImagePickerBlock)(BOOL isSourceTypeAvailable,AVAuthorizationStatus authorizationStatus, UIImage *image);


@interface QMImagePicker : NSObject


/**
 拍照生成图片

 @param vc 当前的控制器
 @param imagePickerBlock 选择相机的回调
 */
- (void)imagePickerWithController:(UIViewController *)vc block:(ImagePickerBlock)imagePickerBlock;

@end
