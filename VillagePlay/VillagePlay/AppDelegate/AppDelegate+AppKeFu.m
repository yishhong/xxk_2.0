//
//  AppDelegate+AppKeFu.m
//  VillagePlay
//
//  Created by Apricot on 16/11/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+AppKeFu.h"
#import "AppKeFuLib.h"

#define APPKEFU_APP_KEY @"10a02e6c596597a95c04efb5d0ceb269"

@implementation AppDelegate (AppKeFu)

- (void)loginAppKeFu{
    [[AppKeFuLib sharedInstance] enableIPServerMode:false];

    [[AppKeFuLib sharedInstance] loginWithAppkey:APPKEFU_APP_KEY];
//    [[AppKeFuLib sharedInstance] loginWithUsername:@"iOS" withAppkey:APPKEFU_APP_KEY];
    NSLog(@"%@",[[AppKeFuLib sharedInstance] getHost]);
//    -(void)loginWithUsername:(NSString *)username withAppkey:(NSString *)appkey;

}

- (void)logoutAppKeFu{
    [[AppKeFuLib sharedInstance] logout];
}

- (void)appKeFuDeviceToken:(NSData *)deviceToken{
    [[AppKeFuLib sharedInstance] uploadDeviceToken:deviceToken];
}



@end
