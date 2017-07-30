//
//  AppDelegate+OpenURL.m
//  VillagePlay
//
//  Created by Apricot on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+OpenURL.h"
#import "AppDelegate+Share.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "MBProgressHUD+Loading.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate (OpenURL)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
    }
    if ([url.host isEqualToString:@"pay"]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    if([self shareOpenURL:url]){
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString * resultStatus = resultDic[@"resultStatus"];
            if([resultStatus isEqualToString:@"9000"]){
                //服务器端查询支付通知或查询API返回的结果再提示成功
                [[NSNotificationCenter defaultCenter]postNotificationName:@"VPWeChatPaySuccessChangeNotification" object:nil];
                [MBProgressHUD hide];
                [MBProgressHUD showTip:@"支付成功"];
                
            }else{
                [MBProgressHUD hide];
                [MBProgressHUD showTip:resultDic[@"memo"]];
                
            }

        }];
    }
    if ([url.host isEqualToString:@"pay"]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
    if([self shareOpenURL:url]){
        return YES;
    }
 
    return YES;
}
@end
