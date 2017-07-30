//
//  AppDelegate.m
//  VillagePlay
//
//  Created by Apricot on 16/10/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Share.h"
#import "AppDelegate+UMeng.h"
#import "AppDelegate+JSPatch.h"
#import "AppDelegate+BMap.h"
#import "AppDelegate+Console.h"
#import "AppDelegate+Appearance.h"
#import "AppDelegate+OpenURL.h"
#import "AppDelegate+JPush.h"
#import "AppDelegate+AppKeFu.h"
#import "AppDelegate+Keyboard.h"
#import "AppDelegate+MainUI.h"
#import "WXApi.h"
#import "MBProgressHUD+Loading.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  log信息
     */
    [self setUpConsole];
    /**
     *  热更新
     */
    [self configJSPatch];
    /**
     *  键盘修改
     */
    [self configKeyboard];
    /**
     *  配置NavigationBar和TabBar的颜色
     */
    [self configAppearance];
    /**
     *  配置极光推送
     */
    [self configJPushLaunchOption:launchOptions];
    /**
     *  友盟统计
     */
    [self configUMAnalytics];
    /**
     *  友盟分享以及登录
     */
    [self configShare];
    /**
     *  百度地图
     */
    [self configBMapKit];
    /**
     *  App客服
     */
    [self loginAppKeFu];
    /**
     *  主页面
     */
    [self showMainUI];
    
    return YES;
}

//微信支付回调

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                [[NSNotificationCenter defaultCenter]postNotificationName:@"VPWeChatPaySuccessChangeNotification" object:nil];
                [MBProgressHUD showTip:@"支付成功"];
                break;
            case WXErrCodeUserCancel:
                [MBProgressHUD showTip:@"取消支付"];
                break;
            default:
                [MBProgressHUD showTip:[NSString stringWithFormat:@"支付失败，retcode=%d",resp.errCode]];
                break;
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //苹果官方规定除特定应用类型，如：音乐、VOIP类可以在后台运行，其他类型应用均不得在后台运行，所以在程序退到后台要执行logout登出，
    //离线消息通过服务器推送可接收到
    //在程序切换到前台时，执行重新登录，见applicationWillEnterForeground函数中
    //步骤四：
    [self logoutAppKeFu];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //切换到前台重新登录
    [self loginAppKeFu];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
