//
//  QMMapFuntion.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "BMapKit.h"

@interface QMMapFuntion : NSObject

/**
 组合经纬度

 @param latitude <#latitude description#>
 @param longitude <#longitude description#>
 @return <#return value description#>
 */
+ (NSString *)combinationCoordinateWithLatitude:(double)latitude longitude:(double)longitude;

/**
 字符串转CLLocationCoordinate2D

 @param location String类型的经纬度
 @return 返回CLLocationCoordinate2D经纬度
 */
+ (CLLocationCoordinate2D)transformCoordinate:(NSString *)location;

/**
 CLLocationCoordinate2D转字符串


 @param coordinate CLLocationCoordinate2D坐标
 @return String类型的经纬度
 */
+ (NSString *)transformCoordinateLocationString:(CLLocationCoordinate2D)coordinate;

/**
 距离换算

 @param startCoord 开始的地址
 @param endCoord 结束的地址
 @return 返回两地间的距离
 */
+ (NSString *)distanseBetweenWithStartCoord:(CLLocationCoordinate2D)startCoord endCoord:(CLLocationCoordinate2D)endCoord;
@end
