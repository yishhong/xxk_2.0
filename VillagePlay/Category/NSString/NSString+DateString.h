//
//  NSString+DateString.h
//  HotelBusiness
//
//  Created by  易述宏 on 16/8/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateString)

/**
 *  计算时间差(精确到天)
 *
 *  @param startTime 开始时间
 *  @param endTime   结束时间
 *
 *  @return 字符串
 */
+(NSString *)dateTimeStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 *  计算时间差(精确到分秒)
 *
 *  @param startTime 开始时间
 *  @param endTime   结束时间
 *
 *  @return 字符串
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

@end
