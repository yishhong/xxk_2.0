//
//  NSString+Height.h
//  HotelBusiness
//
//  Created by Apricot on 16/8/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Height)

/**
 *  计算文本的高度
 *
 *  @param font    字体型号
 *  @param maxSize 最大宽度
 *
 *  @return 返回最后的size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
