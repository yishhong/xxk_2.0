//
//  UIAlertController+MapNavigation.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIAlertController+MapNavigation.h"

@implementation UIAlertController (MapNavigation)

+ (instancetype)mapNavigationWithLocationCoordinate2D:(CLLocationCoordinate2D)locationCoordinate{
    UIAlertController *alertController = [[UIAlertController alloc] init];
    
    NSMutableArray *mapArray = [NSMutableArray array];
    
    [mapArray addObject:@"苹果地图"];
    UIAlertAction *appleMapAction = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude);
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        currentLocation.name = @"我的位置";
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
        toLocation.name = @"终点";
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    
    [alertController addAction:appleMapAction];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
//        [mapArray addObject:@"百度地图"];
        UIAlertAction *baiduMapAction = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",locationCoordinate.latitude, locationCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alertController addAction:baiduMapAction];
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
//        NSLog(@"安装了高德Map");
        [mapArray addObject:@"高德地图"];
        UIAlertAction *gaoDeMapAction = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"下乡客",@"Village://",locationCoordinate.latitude, locationCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alertController addAction:gaoDeMapAction];
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
//        NSLog(@"安装了GoogleMap");
        [mapArray addObject:@"谷歌地图"];
        UIAlertAction *googleMapAction = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"下乡客",@"Village://",locationCoordinate.latitude, locationCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alertController addAction:googleMapAction];
    }
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取  消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:alertAction];
    return alertController;
}

@end
