//
//  QMMediator.h
//  HotelBusiness
//
//  Created by Apricot on 16/8/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+Object.h"

@interface QMMediator : NSObject
+ (instancetype)sharedInstance;
/**
 * 根据URL生成一个控制器
 *
 *  @param urlStr URL
 *  @param object 传值对象 需要一个扩展配合（UIViewController+Object）
 *
 *  @return 返回一个控制器
 */
+ (UIViewController *)openURL:(NSString *)urlStr object:(NSDictionary *)object;
@end
