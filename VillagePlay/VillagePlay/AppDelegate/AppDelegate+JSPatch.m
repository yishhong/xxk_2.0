//
//  AppDelegate+JSPatch.m
//  VillagePlay
//
//  Created by Apricot on 16/5/17.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "AppDelegate+JSPatch.h"
#import <JSPatchPlatform/JSPatch.h>

#define JSPATCH_APPKEY @"cf35f692eb610327"

@implementation AppDelegate (JSPatch)

- (void)configJSPatch{
    [JSPatch startWithAppKey:JSPATCH_APPKEY];
#ifdef DEBUG
    //开发者模式
    [JSPatch setupDevelopment];
#endif
    //设置标签
//    [JSPatch setupUserData:@{@"":@""}];
    //同步文档
    [JSPatch sync];
}

@end
