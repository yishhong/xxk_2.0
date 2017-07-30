//  Copyright (c) 2013年 swinglife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WGS84TOGCJ02 : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
//百度坐标转火星坐标
+(CLLocationCoordinate2D)transfromFromBD09ToGCJ:(CLLocationCoordinate2D)bd09;

@end