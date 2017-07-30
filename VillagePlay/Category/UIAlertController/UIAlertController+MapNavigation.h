//
//  UIAlertController+MapNavigation.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//  地图导航的选项

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface UIAlertController (MapNavigation)

+ (instancetype)mapNavigationWithLocationCoordinate2D:(CLLocationCoordinate2D )locationCoordinate;

@end
