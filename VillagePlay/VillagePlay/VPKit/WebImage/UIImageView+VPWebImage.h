//
//  UIImageView+VPWebImage.h
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//  中间层 主要为了替换图片加载的

#import <UIKit/UIKit.h>

@interface NSString (VPWebImage)

/**
 生成七牛的URL

 @param width 宽度
 @param height 高度
 @return 返回拼接好的URL
 */
- (NSString *)xx_configQiNiuImageUrlWithWidth:(CGFloat)width height:(CGFloat)height;

@end

@interface UIImage (DownloadImage)

+ (void)xx_downImage:(NSString *)imageUrl;

+ (UIImage *)xx_loadImage:(NSString *)imageURL;

@end

@interface UIImageView (VPWebImage)

/**
 *  下载图片
 *
 *  @param imageURLStr 图片的URL
 */
- (void)xx_setImageWithURLStr:(nullable NSString *)imageURLStr;

/**
 *  项目中是用的图片加载
 *
 *  @param imageURLStr 图片的URL字符串
 *  @param placeholder 默认显示的图(UIImage)
 */
- (void)xx_setImageWithURLStr:(nullable NSString *)imageURLStr placeholder:(nullable UIImage *)placeholder;

@end
