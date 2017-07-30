//
//  VPCalendarViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCalendarViewModel.h"
#import "QMCalendarFunction.h"



@interface VPCalendarViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *valueDict;
@property (assign, nonatomic) BOOL isBack;
@end

@implementation VPCalendarViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isBack = YES;
        self.dataSource = [NSMutableArray array];
        self.valueDict = [NSMutableDictionary dictionary];

    }
    return self;
}

- (NSMutableArray *)fetchTimeData{
    return  self.dataSource;
}

- (NSMutableDictionary *)fetchValueData{
    return self.valueDict;
}

- (void)timeData{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSDate *nowDate = [NSDate date];
//    [dateFormatter setDateFormat:@"yyyy"];
//    NSInteger nowYear = [[dateFormatter stringFromDate:nowDate] integerValue];
//    [dateFormatter setDateFormat:@"MM"];
//    NSInteger nowMonth = [[dateFormatter stringFromDate:nowDate] integerValue];
//    [dateFormatter setDateFormat:@"dd"];
//    NSInteger nowDay = [[dateFormatter stringFromDate:nowDate] integerValue];
    
    //获取60天以内日历数据
    QMCalendarFunction *calendarFunction = [[QMCalendarFunction alloc] init];
    self.dataSource = [[calendarFunction nowBeginToEndInEndDate:[calendarFunction futureDay:60]] mutableCopy];
}

//是否当前选中的 beginDate
/*
 beginDate
 endDate
 */

- (void)configBeginDate:(NSString *)beginDate endDate:(NSString *)endDate{
    [self timeData];
    NSArray *beginArray = [beginDate componentsSeparatedByString:@"-"];
    self.valueDict[@"beginDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",[beginArray[0] integerValue],[beginArray[1] integerValue],[beginArray[2] integerValue]];
    
    NSArray *endArray = [endDate componentsSeparatedByString:@"-"];
    self.valueDict[@"endDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",[endArray[0] integerValue],[endArray[1] integerValue],[endArray[2] integerValue]];
}

- (BOOL)selectDay:(NSInteger)day withMonth:(NSInteger)month withyear:(NSInteger)year{
    NSString * selectDate = [NSString stringWithFormat:@"%zd%02zd%02zd",year,month,day];
    if([selectDate integerValue]<=[self.valueDict[@"beginDate"] integerValue]){
        self.isBack = YES;
    }
    if(self.isBack){
        self.isBack = NO;
        self.valueDict[@"beginDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",year,month,day];
        self.valueDict[@"endDate"] = self.valueDict[@"beginDate"];
    }else{
        self.isBack = YES;
        self.valueDict[@"endDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",year,month,day];
    }
    return self.isBack;
}

@end
