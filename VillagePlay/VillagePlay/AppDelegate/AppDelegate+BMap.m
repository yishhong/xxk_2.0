//
//  AppDelegate+BMap.m
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+BMap.h"
#import "BMapKit.h"
#import "VPLocationManager.h"

/*
 注意这里的BMAP_APPKEY放到了.h文件中 主要用于生成地图图片的URL
 */

@interface AppDelegate ()<BMKGeneralDelegate>

@end


@implementation AppDelegate (BMap)

- (void)configBMapKit{
#ifdef DEBUG
    [BMKMapManager logEnable:YES module:BMKMapModuleTile];
#endif
    // 要使用百度地图，请先启动BaiduMapManager
    BMKMapManager * mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:BMAP_APPKEY generalDelegate:self];
    NSAssert(ret, @"BMKMapManager start failed!");

    
}
- (void)onGetNetworkState:(int)iError{
    if(iError==0){
        [[VPLocationManager sharedManager] startLocation:^(NSError *error, CLLocationCoordinate2D locationCoordinate) {
            if(error){
                NSLog(@"%@",error.description);
            }
        }];
    }
    NSLog(@"%s %d",__func__,iError);
}

- (void)onGetPermissionState:(int)iError{
    if(iError==0){
        
    }
    NSLog(@"%s %d",__func__,iError);
}
@end
