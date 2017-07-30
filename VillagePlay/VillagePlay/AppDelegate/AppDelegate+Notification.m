//
//  AppDelegate+Notification.m
//  VillagePlay
//
//  Created by Apricot on 16/11/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+Notification.h"
#import "AppDelegate+JPush.h"
#import "AppDelegate+AppKeFu.h"

@implementation AppDelegate (Notification)
#pragma mark - Appdelegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //注册极光推送
    [self jpushDeviceToken:deviceToken];
    //注册AppKeFu推送
    [self appKeFuDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [self handleRemoteNotificationForJSPush:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [self handleRemoteNotificationForJSPush:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

@end
