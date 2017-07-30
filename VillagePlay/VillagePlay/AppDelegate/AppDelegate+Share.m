//
//  AppDelegate+Share.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/17.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+Share.h"
#import <UMSocialCore/UMSocialCore.h>


#define UMENG_APPKEY @"54aa2bbcfd98c5050d0010b3"

@implementation AppDelegate (Share)

-(void)configShare{

#ifdef DEBUG
    [[UMSocialManager defaultManager] openLog:YES];
#endif
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMENG_APPKEY];
    
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa307586ab3cf9968" appSecret:@"7977ddbeebb5b2ed7d015838568b2ded" redirectURL:@"http://www.xiaxiangke.com"];
    //设置微信朋友圈的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxa307586ab3cf9968" appSecret:@"7977ddbeebb5b2ed7d015838568b2ded" redirectURL:@"http://www.xiaxiangke.com"];

    //设置分享到QQ的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105207656"  appSecret:@"WANxADhfAZwsAB0B" redirectURL:@"http://www.xiaxiangke.com"];
    //设置分享到QQ空间的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1105207656"  appSecret:@"WANxADhfAZwsAB0B" redirectURL:@"http://www.xiaxiangke.com"];
    
    //设置新浪的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3636603220"  appSecret:@"c0396e446767ae2a39a552f4ba380b38" redirectURL:@"http://www.xiaxiangke.com"];
    
    [[UMSocialManager defaultManager]removePlatformProviderWithPlatformType:UMSocialPlatformType_WechatFavorite];
}
- (BOOL)shareOpenURL:(NSURL *)url{
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}
@end
