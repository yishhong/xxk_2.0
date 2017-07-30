//
//  QMMapFuntion.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMMapFuntion.h"

@implementation QMMapFuntion

+ (NSString *)combinationCoordinateWithLatitude:(double)latitude longitude:(double)longitude{
    return [NSString stringWithFormat:@"%f,%f",latitude,longitude];
}

+ (CLLocationCoordinate2D)transformCoordinate:(NSString *)location{
    NSArray *array = [location componentsSeparatedByString:@","];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
    if (array.count == 2) {
        double latitude = [array[0] doubleValue];
        double longitude = [array[1] doubleValue];
        coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return coordinate;
}

+ (NSString *)transformCoordinateLocationString:(CLLocationCoordinate2D)coordinate{
    if (coordinate.latitude == 0 && coordinate.longitude == 0) {
        return nil;
    }
    NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    return [[latitude stringByAppendingString:@","] stringByAppendingString:longitude];
}

+ (NSString *)distanseBetweenWithStartCoord:(CLLocationCoordinate2D)startCoord endCoord:(CLLocationCoordinate2D)endCoord{
    return [NSString stringWithFormat:@"%0.2f",BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(startCoord),BMKMapPointForCoordinate(endCoord))/1000];
}


@end
