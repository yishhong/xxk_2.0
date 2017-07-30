//
//  AppDelegate+JPush.m
//  HotelBusiness
//
//  Created by  易述宏 on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import <AVFoundation/AVFoundation.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#ifdef DEBUG
#define JPUSH_APPKEY @"beb6f1d41fdf4b9ed23dc332" //测试推送的kEY BundleIdentifie为com.qineng.villageplay.db
#else
#define JPUSH_APPKEY @"9a2618c19e29be2a2c26a640"
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate (JPush)

/*!
 * @abstract 启动SDK
 *
 * @param launchingOption 启动参数.
 * @param appKey 一个JPush 应用必须的,唯一的标识. 请参考 JPush 相关说明文档来获取这个标识.
 * @param channel 发布渠道. 可选.
 * @param isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
 * @param advertisingIdentifier 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
 *
 * @discussion 提供SDK启动必须的参数, 来启动 SDK.
 * 此接口必须在 App 启动时调用, 否则 JPush SDK 将无法正常工作.
 */

-(void)configJPushLaunchOption:(NSDictionary *)launchOptions{
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionAlert;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UNAuthorizationOptionAlert |
                                                          UNAuthorizationOptionBadge |
                                                          UNAuthorizationOptionSound)
                                              categories:nil];
//        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
//        entity.types = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;

        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }else{
        //categories 必须为nil
//        entity.types = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert;

        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    // Required
    //是否打印log信息
#if DEBUG
    [JPUSHService setDebugMode];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY channel:@"Publish channel" apsForProduction:NO];
#else
    [JPUSHService setLogOFF];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY channel:@"Publish channel" apsForProduction:YES];

#endif
    //清空角标
    [self resetBadge];
}

/**
 注册APN

 @param deviceToken <#deviceToken description#>
 */
-(void)jpushDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}

-(void)handleRemoteNotificationForJSPush:(NSDictionary *)userinfo{
//        NSDictionary *aps = [userinfo valueForKey:@"aps"];
//    //    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
////        NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
//    //    NSString *music =[aps valueForKey:@"orderMessage"];
//    
//    //通过推送获取的sound字段判断是否是订单推送
//    if(![aps[@"sound"] isEqualToString:@"default"]){
////        if(![HBUserManager isLogin]){
////            return;
////        }
////        [[HBMessageManager sharedManager] updataReserveMessageUnreadCount];
//        //通知首页更新界面
//        switch ([UIApplication sharedApplication].applicationState) {
//            case UIApplicationStateActive:{
//                //提示信息
//                SystemSoundID soundID;
//                NSString * pathString =[[NSBundle mainBundle]pathForResource:@"orderMessage" ofType:@"MP3"];
//                NSURL * url =[NSURL fileURLWithPath:pathString];
//                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
//                AudioServicesPlaySystemSound(soundID);
//                
//            }break;
//            case UIApplicationStateInactive:
//            case UIApplicationStateBackground:{
//                //页面跳转
////                UIViewController *VC = [QMMediator openURL:@"hotel://HBMessageViewController" object:@{}];
////                UIViewController *rootViewController = self.window.rootViewController;
////                if([rootViewController isKindOfClass:[UINavigationController class]]){
////                    UINavigationController *navigationVC = (UINavigationController *)rootViewController;
////                    NSMutableArray *vcArray = [navigationVC.viewControllers mutableCopy];
////                    [vcArray removeObjectsInRange:NSMakeRange(1, vcArray.count-1)];
////                    navigationVC.viewControllers = vcArray;
////                    [navigationVC pushViewController:VC animated:YES];
////                
////                }
//            }break;
//            default:{
//            }break;
//    }
//    }else{
//        //系统通知
////        [[HBMessageManager sharedManager] updataSystemMessageUnreadCount];
//    }
    [JPUSHService handleRemoteNotification:userinfo];
}

/**
 清理角标
 */
- (void)resetBadge{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
}


#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}



@end
