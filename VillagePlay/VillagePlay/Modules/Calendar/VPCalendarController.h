//
//  VPCalendarController.hController
//  VillagePlay
//
//  Created by Apricot on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"

typedef void(^SelectDate)(NSString *beginDate,NSString *endDate);

@interface VPCalendarController : VPBaseViewController

+ (instancetype)instantiation;

/*
 开始时间
 */
@property (nonatomic, strong) NSString *beginDate;

/**
 结束时间
 */
@property (nonatomic, strong) NSString *endDate;

/**
 选择时间的回调
 */
@property (nonatomic, copy) SelectDate selectDate;


@end
