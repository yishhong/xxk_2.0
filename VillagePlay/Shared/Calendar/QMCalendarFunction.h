//
//  QMCalendarFunction.h
//  HotelBusiness
//
//  Created by Apricot on 16/8/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMCalendarFunction : NSObject

//获取当地时间
- (NSString *)getCurrentTime;

//将字符串转成NSDate类型
- (NSDate *)dateFromString:(NSString *)dateString;

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSDate *)aDate;

/**
 时间转换成MM-dd格式

 @param currentTime 时间字符串
 */
- (NSString *)currentDatefromString:(NSString *)currentTime;

/**
 转换成 yyyy-MM-dd格式

 @param currentTime 时间
 @return <#return value description#>
 */
- (NSString *)currentDateString:(NSString *)timeString;

//取当天的时间
/**
 *  获取当前时间
 */
- (void)nowDate;
/**
 *  当前时间时间算起，未来几年
 *
 *  @param yearTime 几年时间
 *
 *  @return 返回yearTime年后的date
 */
- (NSDate *)futureYear:(NSInteger)yearTime;
/**
 *  当前时间时间算起，未来几个月
 *
 *  @param monthTime 几月的时间
 *
 *  @return 返回monthTime月后的date
 */
- (NSDate *)futureMonth:(NSInteger)monthTime;


/**
 当前时间时间算起，未来多少天

 @param dayTime 几天的时间
 @return 返回dayTime天后的date
 */
- (NSDate *)futureDay:(NSInteger)dayTime;

/**
 *  转化年月为date数据
 *
 *  @param year  年
 *  @param month 月
 *
 *  @return 返回指定年月的date
 */
- (NSDate *)transformDateWithYear:(NSInteger)year withMonth:(NSInteger)month;

//生成一段时间内的年月数组[{@"year":year,@"month":month,@"days":dayArray}]
/**
 *  当前时间算起到指定时间所有的的年月日信息
 *
 *  @param enddate 结束时间
 *
 *  @return 返回年月日的信息
 */
- (NSArray *)nowBeginToEndInEndDate:(NSDate *)enddate;

/**
 *  从beginDate到endDate的时间域所有的年月份数据
 *
 *  @param beginDate 开始时间
 *  @param endDate   结束时间
 *
 *  @return 返回年月日的信息
 */
- (NSArray *)beginTime:(NSDate *)beginDate endTime:(NSDate *)endDate;
//生成当前月的day数组 按周日开头排 并且是否加入数据[{@"day":day,@"other":other}]
/**
 *  获取指定年月的所有day数据
 *
 *  @param year  年
 *  @param month 月
 *
 *  @return 该月的day数据
 */
- (NSArray *)dayArrayWithYear:(NSInteger)year withMonth:(NSInteger)month;
/**
 *  从现在时间到 指定endDate的年月
 *
 *  @param endDate 指定endDate时间(结束)
 *
 *  @return 返回年月日的信息
 */
- (NSArray *)yearAndMonthWithDate:(NSDate *)endDate;
//获取某个月有几周
/**
 *  某月有几周
 *
 *  @param dayArray <#dayArray description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)getWeekWithDayArray:(NSArray *)dayArray;

/**
 *  获取一天的时间
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)getDayTime;

/**
 获取某年某月某日的星期

 @param dateString 时间
 @return <#return value description#>
 */
-(NSString *)weekDay:(NSString *)dateString;

@end
