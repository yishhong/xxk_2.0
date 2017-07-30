//
//  UISearchBar+Custom.h
//  VillagePlay
//
//  Created by Apricot on 16/10/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (Custom)

///**
// *  用于带有定位的SearchBar
// */
//- (void)customSearchBarInLocation;
//
///**
// *  首页导航栏的SearchBar
// */
//- (void)customSearchBarInNavigation;
//
///**
// *  搜索界面的SearchBar
// */
//- (void)customSearchBarInSearchController;

/**
 *  设置搜索输入框的 字体
 *
 *  @param font 字体
 */
- (void)xxTextFont:(UIFont *)font;
/**
 *  设置搜索输入框的字体颜色
 *
 *  @param textColor 字体颜色
 */
- (void)xxTextColor:(UIColor *)textColor;
/**
 *  设置取消按钮的Title
 *
 *  @param title 取消按钮的Title
 */
- (void)xxCancelButtonTitle:(NSString *)title;
/**
 *  修改取消按钮的颜色不修改输入框的颜色
 *
 *  @param titleColor 文字颜色
 
 */
- (void)xxCancelButtonTitleColor:(UIColor *)titleColor;
/**
 *  设置取消按钮的title 字体
 *
 *  @param font 字体
 */
- (void)xxCancelButtonFont:(UIFont *)font;
@end
