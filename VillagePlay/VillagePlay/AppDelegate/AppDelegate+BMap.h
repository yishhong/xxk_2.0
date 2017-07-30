//
//  AppDelegate+BMap.h
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate.h"

#ifdef DEBUG
#define BMAP_APPKEY @"4NGETjpAEDeCOb8vjDkUl3bmEK76qdzL" //测试版本KEY 账号为个人的 BundleIdentifie为com.qineng.villageplay.db
#else
#define BMAP_APPKEY @"tdQpg9YCvQELvz5NeaSNiI0i" //正式版本的KEY 账号未知
#endif


@interface AppDelegate (BMap)
- (void)configBMapKit;
@end
