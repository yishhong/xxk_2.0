//
//  AppDelegate+Keyboard.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+Keyboard.h"
#import "IQKeyboardManager.h"

@implementation AppDelegate (Keyboard)

-(void)configKeyboard{

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar = NO;//这个是它自带键盘工具条开关
}

@end
