//
//  VPCalendarViewModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPCalendarViewModel : NSObject

/**
 *  获取时间的数据
 *
 *  @return 返回获取的数据
 */
- (NSMutableArray *)fetchTimeData;

/**
 *  获取显示的值数据
 *
 *  @return 返回获取的数据
 */
- (NSMutableDictionary *)fetchValueData;

/**
 配置开始的时间和结束的时间 (时间格式2016-12-03)

 @param beginDate 开始的时间
 @param endDate 结束的时间
 */
- (void)configBeginDate:(NSString *)beginDate endDate:(NSString *)endDate;

/**
 选择时间

 @param day 天
 @param month 月
 @param year 年
 @return 返回是完成选择
 */
- (BOOL)selectDay:(NSInteger)day withMonth:(NSInteger)month withyear:(NSInteger)year;

@end
