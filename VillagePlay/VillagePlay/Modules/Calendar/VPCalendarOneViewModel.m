//
//  VPCalendarOneViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCalendarOneViewModel.h"
#import "QMCalendarFunction.h"

@interface VPCalendarOneViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *valueDict;
@property (assign, nonatomic) BOOL isBack;
@end

@implementation VPCalendarOneViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
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
- (void)configSelectDate:(NSString *)selectDate{
    [self timeData];
    NSArray *beginArray = [selectDate componentsSeparatedByString:@"-"];
    self.valueDict[@"selectDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",[beginArray[0] integerValue],[beginArray[1] integerValue],[beginArray[2] integerValue]];
}


//- (BOOL)selectDay:(NSInteger)day withMonth:(NSInteger)month withyear:(NSInteger)year{
//    NSString * selectDate = [NSString stringWithFormat:@"%zd%02zd%02zd",year,month,day];
//    if([selectDate integerValue]<=[self.valueDict[@"beginDate"] integerValue]){
//        self.isBack = YES;
//    }
//    if(self.isBack){
//        self.isBack = NO;
//        self.valueDict[@"beginDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",year,month,day];
//        self.valueDict[@"endDate"] = self.valueDict[@"beginDate"];
//    }else{
//        self.isBack = YES;
//        self.valueDict[@"endDate"] = [NSString stringWithFormat:@"%zd%02zd%02zd",year,month,day];
//    }
//    return self.isBack;
//}

@end
