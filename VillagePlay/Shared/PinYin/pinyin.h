/*
 *  pinyin.h
 *  Chinese Pinyin First Letter
 *
 *  Created by George on 4/21/10.
 *  Copyright 2010 RED/SAFI. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

char pinyinFirstLetter(unsigned short hanzi);


@interface HTFirstLetter : NSObject

/**
 获取汉字首字母，如果参数既不是汉字也不是英文字母,则返回 @“#”

 @param chineseString 汉字
 @return 返回汉字首字母
 */
+ (NSString *)firstLetter:(NSString *)chineseString;

/**
 返回参数中所有汉字的首字母，遇到其他字符,则用 # 替换

 @param chineseString 汉字
 @return 所有汉字的首字母
 */
+ (NSString *)firstLetters:(NSString *)chineseString;

@end
