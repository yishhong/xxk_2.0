//
//  NSString+DateString.m
//  HotelBusiness
//
//  Created by  易述宏 on 16/8/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "NSString+DateString.h"

@implementation NSString (DateString)

+(NSString *)dateTimeStartTime:(NSString *)startTime endTime:(NSString *)endTime{

    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970];
    
    NSTimeInterval end = [endD timeIntervalSince1970];
    
    NSTimeInterval value = (end - start)/(24 * 3600);
    
    NSString * dayString =[NSString stringWithFormat:@"%.f",value];
    
    return dayString;
}



+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
    if (day != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
        
    }else if (day==0 && house != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
        
    }else if (day== 0 && house== 0 && minute!=0) {
        
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
        
    }else{
        
        str = [NSString stringWithFormat:@"耗时%d秒",second];
        
    }
    
    return str;
    
}

@end
