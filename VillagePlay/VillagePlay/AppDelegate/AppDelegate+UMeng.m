//
//  AppDelegate+UMeng.m
//  VillagePlay
//
//  Created by Apricot on 16/3/26.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import <UMMobClick/MobClick.h>

@implementation AppDelegate (UMeng)

#define UMENG_APPKEY @"54aa2bbcfd98c5050d0010b3"

- (void)configUMAnalytics{
    
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = nil;
    UMConfigInstance.ePolicy = BATCH; 
    [MobClick startWithConfigure:UMConfigInstance];
    
#ifdef DEBUG
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setLogEnabled:YES];
#endif
    //获取版本号
    [MobClick setAppVersion:XcodeAppVersion];
    //捕获异常
    [MobClick setCrashReportEnabled:YES];
}

@end
