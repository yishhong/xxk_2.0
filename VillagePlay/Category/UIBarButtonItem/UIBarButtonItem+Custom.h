//
//  UIBarButtonItem+Custom.h
//  VillagePlay
//
//  Created by Apricot on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)
/**
 *  设置字体
 *
 *  @param font 字体
 */
- (void)xx_setFont:(UIFont *)font;
/**
 *  设置字号
 *
 *  @param size 字号大小
 */
- (void)xx_setFontSize:(CGFloat)size;

/**
 *  设置下乡客的导航按钮文字字体以及字号
 */
- (void)xx_barButtonTitleFont;
@end
