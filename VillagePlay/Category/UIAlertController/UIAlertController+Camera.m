//
//  UIAlertController+Camera.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIAlertController+Camera.h"

@implementation UIAlertController (Camera)

+ (instancetype)selectCameraOrPhotoBlock:(void (^)(NSInteger))block{
    UIAlertController *alertController = [[UIAlertController alloc] init];
    UIAlertAction *cameraAlert = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block(0);
    }];
    [alertController addAction:cameraAlert];
    UIAlertAction *photoAlert = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block(1);
    }];
    [alertController addAction:photoAlert];
    
    UIAlertAction * cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancelAlert];
    return alertController;
}

@end
