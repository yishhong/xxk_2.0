//
//  UIApplication+System.h
//  VillagePlay
//
//  Created by Apricot on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (System)
/**
 *  拨打电话
 *
 *  @param phoneNumber 手机号码
 */
+ (void)callPhone:(NSString *)phoneNumber;

/**
 *  发送短信
 *
 *  @param phoneNumber 手机号码
 */
+(void)sendMessage:(NSString *)phoneNumber;
@end
