//
//  NSString+NumberRound.h
//  VillagePlay
//
//  Created by Apricot on 2017/1/9.
//  Copyright © 2017年 Apricot. All rights reserved.
//  解决数值的四舍五入的问题

#import <Foundation/Foundation.h>

@interface NSString (NumberRound)

/**
 解决四舍五入的问题 这里主要用在播放次数的地方（除以万次,万次以下不做处理直接返回）

 @return 如果数值超过1W则返回以万结尾的单位 否则返回原数值
 */
- (NSString *)numericalConversion;
@end
