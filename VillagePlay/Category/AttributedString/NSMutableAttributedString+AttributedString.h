//
//  NSMutableAttributedString+AttributedString.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (AttributedString)


/**
 修改字体的间距 目前适用于下乡客的旅游CELL 有待优化

 @param string 需要处理的字符串
 @return 返回处理以后的可编辑字符串
 */
- (NSMutableAttributedString *)attributedString:(NSString *)string;

/**
 <#Description#>

 @param contentString <#contentString description#>
 @param paragraph <#paragraph description#>
 @return <#return value description#>
 */
-(NSMutableAttributedString *)attributedString:(NSString *)contentString paragraph:(CGFloat)paragraph;


/**
 改变某一段字符串颜色

 @param allString 字符串所有有内容
 @param changeColorString 需要改变字符串的内容
 @return <#return value description#>
 */
- (NSMutableAttributedString *)rangeAttributedString:(NSString *)allString changeColorString:(NSString *)changeColorString;

/**
 改变指定字符串长度的颜色

 @param changeColorString 变色字符串
 @param range <#range description#>
 @return <#return value description#>
 */
-(NSMutableAttributedString *)changeColorString:(NSString *)changeColorString location:(NSInteger)location length:(NSInteger)length;

@end
