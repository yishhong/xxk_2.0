//
//  AppDelegate+Share.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/17.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Share)
/**
 *  配置UMengShareSDK
 */
-(void)configShare;

/**
 *  分享的回调
 *
 *  @param url 回调的URL
 *
 *  @return 返回是否是UMeng分享或者登陆的来源打开app
 */
- (BOOL)shareOpenURL:(NSURL *)url;
@end
