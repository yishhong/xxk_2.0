//
//  AppDelegate+JPush.h
//  HotelBusiness
//
//  Created by  易述宏 on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)

-(void)configJPushLaunchOption:(NSDictionary *)launchOptions;

-(void)jpushDeviceToken:(NSData *)deviceToken;

-(void)handleRemoteNotificationForJSPush:(NSDictionary *)userinfo;
/**
 *  重置极光的角标
 */
- (void)resetBadge;
@end
