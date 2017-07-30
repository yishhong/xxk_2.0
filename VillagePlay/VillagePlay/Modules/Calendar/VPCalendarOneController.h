//
//  VPCalendarOneController.hController
//  VillagePlay
//
//  Created by Apricot on 2016/12/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectDate)(NSInteger day,NSInteger month, NSInteger year);

@interface VPCalendarOneController : UIViewController

+ (instancetype)instantiation;
/**
 选择时间的回调
 */
@property (nonatomic, copy) SelectDate selectDateBlock;

/**
 时间
 */
@property (nonatomic, strong) NSString *selectDate;

@end
