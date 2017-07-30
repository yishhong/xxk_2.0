//
//  AppDelegate+Appearance.m
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+Appearance.h"
#import "UIColor+HUE.h"
#import "UINavigationBar+Custom.h"

@implementation AppDelegate (Appearance)

- (void)configAppearance{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UINavigationBar appearance] setTranslucent:NO];
    UIImage *backImage = [UIImage imageNamed:@"icon_back_bule"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = backImage;
    [UINavigationBar appearance].backIndicatorImage = backImage;
    [[UINavigationBar appearance] xx_titleStyleWithColor:[UIColor blackTextColor]];

    [[UITabBar appearance] setTranslucent:NO];
    
    //设置返回按钮的文字偏移出屏幕
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    


    //    UINavigationItem *backItem = [UINavigationBar appearance].backItem;
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    backItem.backBarButtonItem = backBarButtonItem;
    
    /*
     self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icon_back_bule"];
     self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"icon_back_bule"];
     */
    
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"icon_back_bule"]
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsDefault];
    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];


    
    
//    [[UIAlertView appearance] setTintColor:[UIColor redColor]];

    
#warning 以下代码与
//    [[UINavigationBar appearance] setTintColor:[UIColor navigationTintColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarTintColor]];
//    [[UITabBar appearance] setTintColor:[UIColor tabTintColor]];
//    [[UITabBar appearance] setBarTintColor:[UIColor tabBarTintColor]];

}

@end
