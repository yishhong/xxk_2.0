//
//  VPLocationManager.m
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLocationManager.h"
#import "AppDelegate+BMap.h"
#import "InfoPlist.h"
#import "VPOpenCityInfoModel.h"
#import "VPStorageManager.h"
#import "VPCityAPI.h"
#import "NSError+Reason.h"

@interface VPLocationManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

/**
 定位管理器
 */
@property (nonatomic, strong) BMKLocationService *locService;

/**
 定位的回调
 */
@property (nonatomic, strong) LocationBlock locationBlock;

/**
 逆地址管理器
 */
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

/**
 逆地址回调
 */
@property (nonatomic, strong) GeoCodeSearchBlock geoCodeSearchBlock;

@property (nonatomic, strong) VPCityAPI *cityAPI;

/**
 所有分类的当前定位
 */
@property (nonatomic, strong) NSMutableDictionary * typeLocationDict;

@property (nonatomic, strong) NSMutableDictionary * typeArrayLocationDict;

@end

@implementation VPLocationManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static id _shared;
    dispatch_once(&onceToken, ^{
        _shared = [[[self class] alloc] init];
    });
    return _shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cityAPI = [[VPCityAPI alloc] init];
        //初始化
        self.isLocation = NO;
        self.locService = [[BMKLocationService alloc] init];
        self.locService.delegate = self;
        self.geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        self.geoCodeSearch.delegate = self;
        
        self.typeArrayLocationDict = [NSMutableDictionary dictionary];
        //数据库中获取选中的城市
        self.typeLocationDict = [NSMutableDictionary dictionaryWithDictionary:[VPStorageManager loadCityDict]];
    }
    return self;
}

- (void)loadRealCityListWithType:(LocationCoordinateType)type success:(void(^)(NSArray *))success failure:(void(^)(NSError * error))failure{
    if([[self.typeArrayLocationDict allKeys] containsObject:@(type)]&&[self.typeArrayLocationDict[@(type)] count]>0){
        success(self.typeArrayLocationDict[@(type)]);
        return;
    }
    if(type == LocationCoordinateTypeDestination){
        //获取目的地
        [self.cityAPI loadCityListWithParams:nil success:^(NSDictionary *responseDict) {
            //加载成功
            NSMutableArray * openCityArray = [NSMutableArray array];
            openCityArray = [[NSArray yy_modelArrayWithClass:[VPOpenCityInfoModel class] json:responseDict[@"body"]] mutableCopy];
            self.typeArrayLocationDict[@(type)] = openCityArray;
            NSInteger i = 0;
            VPOpenCityInfoModel * nationwideCityModel =nil;
            for (VPOpenCityInfoModel *infoModel in openCityArray) {
                if([infoModel.vid isEqualToString:@"0"]){
                    nationwideCityModel = infoModel;
                    nationwideCityModel.cityName = @"全国";
                    break;
                }
                    i++;
            }
            if(nationwideCityModel){
                [openCityArray insertObject:nationwideCityModel atIndex:0];
                [openCityArray removeObjectAtIndex:i];
            }
            
            if(!self.typeLocationDict[@(type)]){
                VPOpenCityInfoModel *cityInfoModel = [[VPOpenCityInfoModel alloc] init];
                cityInfoModel.cityName = @"长沙市";
                cityInfoModel.vid = @"186";
                self.typeLocationDict[@(type)] = cityInfoModel;
                if(!self.isLocation){
                    VPOpenCityInfoModel *cityModel = [self isOpenCityWithType:type];
                    if(cityModel){
                        self.typeLocationDict[@(type)] = cityModel;
                    }
                }
                [self saveLocationCoordinate2DWithType:type cityModel:self.typeLocationDict[@(type)]];
            }
            success(openCityArray);
        } failure:^(NSError *error) {
            //加载失败
            failure(error);
        }];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"type"] = @(type);
        [self.cityAPI loadRealCityListWithParams:params success:^(NSDictionary *responseDict) {
            NSMutableArray * openCityArray = [NSMutableArray array];
            openCityArray = [[NSArray yy_modelArrayWithClass:[VPOpenCityInfoModel class] json:responseDict[@"body"]] mutableCopy];
            //
            NSInteger i = 0;
            VPOpenCityInfoModel * nationwideCityModel =nil;
            for (VPOpenCityInfoModel *infoModel in openCityArray) {
                if([infoModel.vid isEqualToString:@"0"]){
                    nationwideCityModel = infoModel;
                    nationwideCityModel.cityName = @"全国";
                    break;
                }
                i++;
            }
            if(nationwideCityModel){
                [openCityArray insertObject:nationwideCityModel atIndex:0];
                [openCityArray removeObjectAtIndex:i];
            }
            
            self.typeArrayLocationDict[@(type)] = openCityArray;
            if(!self.typeLocationDict[@(type)]){
                self.typeLocationDict[@(type)] = [self defaultCityModel];
                if(!self.isLocation){
                    VPOpenCityInfoModel *cityModel = [self isOpenCityWithType:type];
                    if(cityModel){
                        self.typeLocationDict[@(type)] = cityModel;
                    }
                }
                [self saveLocationCoordinate2DWithType:type cityModel:self.typeLocationDict[@(type)]];
            }
            success(openCityArray);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (VPOpenCityInfoModel *)locationCoordinate2DWithType:(LocationCoordinateType)type{
    VPOpenCityInfoModel *cityModel = nil;
    cityModel =  self.typeLocationDict[@(type)];
    return cityModel;
}

- (void)saveLocationCoordinate2DWithType:(LocationCoordinateType)type cityModel:(VPOpenCityInfoModel *)cityModel{
    self.typeLocationDict[@(type)] = cityModel;
    [VPStorageManager saveSelectCityDict:self.typeLocationDict];
}


- (VPOpenCityInfoModel *)isOpenCityWithType:(LocationCoordinateType)type{
    if(![[self.typeArrayLocationDict allKeys] containsObject:@(type)]&&[self.typeArrayLocationDict[@(type)] count]<1){
        return nil;
    }
    NSArray *cityArray = self.typeArrayLocationDict[@(type)];
    for (VPOpenCityInfoModel *cityModel in cityArray) {
        if([self.geoLocation.addressDetail.city rangeOfString:cityModel.cityName].location != NSNotFound){
            self.cityModel = cityModel;
            return cityModel;
        }
    }
    return nil;
}
- (BOOL)isOpenCityReturnBoolWithType:(LocationCoordinateType)type{
    if(![[self.typeArrayLocationDict allKeys] containsObject:@(type)]&&[self.typeArrayLocationDict[@(type)] count]<1){
        return NO;
    }
    NSArray *cityArray = self.typeArrayLocationDict[@(type)];
    for (VPOpenCityInfoModel *cityModel in cityArray) {
        if([self.geoLocation.addressDetail.city rangeOfString:cityModel.cityName].location != NSNotFound){
            self.cityModel = cityModel;
            return YES;
        }
    }
    return NO;
}

- (void)startLocation:(LocationBlock)locationBlock{
    if(locationBlock){
        if(self.locationBlock){
            self.locationBlock = nil;
        }
        self.locationBlock = locationBlock;
    }
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    switch (authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:{
//            CLLocationManager *locationManager =  [[CLLocationManager alloc] init];
//            [locationManager startUpdatingLocation];
//            [locationManager stopUpdatingLocation];
        }break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"已同意使用");
        }break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:{
            NSLog(@"不可使用");
        }break;
            
        default:
            break;
    }
    [self.locService startUserLocationService];
}

#pragma mark - LocationDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.locService stopUserLocationService];
    //转码
    __weak typeof(VPLocationManager) * weakSelf = self;
    [self reverseGeoCode:userLocation.location.coordinate block:^(BOOL isSuccee, BMKReverseGeoCodeResult *result) {
        if (isSuccee) {
            weakSelf.geoLocation = result;
            weakSelf.isLocation = YES;
            weakSelf.location = userLocation.location.coordinate;
            if(weakSelf.locationBlock){
                weakSelf.locationBlock(nil,userLocation.location.coordinate);
            }
        }else{
            NSError *error = [NSError errorCode:1025 message:@"获取失败"];
            if(weakSelf.locationBlock){
                weakSelf.locationBlock(error,userLocation.location.coordinate);
            }
        }
        
    }];
}


- (void)didFailToLocateUserWithError:(NSError *)error{
    [self.locService stopUserLocationService];
    if(!error){
        self.isLocation = YES;
    }
    if(self.locationBlock){
        self.location = [self defaultLocation];
        self.locationBlock(error,[self defaultLocation]);
    }
    //获取定位失败
}

- (void)reverseGeoCode:(CLLocationCoordinate2D)locationCoordinate2D block:(GeoCodeSearchBlock)geoCodeSearchBlock{
    if(geoCodeSearchBlock){
        if(self.geoCodeSearchBlock){
            self.geoCodeSearchBlock = nil;
        }
        self.geoCodeSearchBlock = geoCodeSearchBlock;
    }
    //初始化逆地理编码类
    BMKReverseGeoCodeOption* reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    //需要逆地理编码的坐标位置
    reverseGeoCodeOption.reverseGeoPoint = locationCoordinate2D;
    if([self.geoCodeSearch reverseGeoCode:reverseGeoCodeOption]){
        NSLog(@"逆地址成功");
    }else{
        BMKReverseGeoCodeResult *result = [[BMKReverseGeoCodeResult alloc] init];
        self.geoCodeSearchBlock(NO,result);
        NSLog(@"逆地址失败");
    }
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if(self.geoCodeSearchBlock){
        self.geoCodeSearchBlock(YES,result);
    }
    NSLog(@"%@",result.addressDetail.city);
//    _localizationCity.cityName = (NSString<Optional> *)result.addressDetail.city;
//    
//    [self getCityData];
}

- (CLLocationCoordinate2D)defaultLocation{
    CLLocationCoordinate2D c;
    c.latitude = 28.000;
    c.longitude = 186.0000;
    return c;
}

+ (CLAuthorizationStatus)locationAuthorizationStatus{
    if(![CLLocationManager locationServicesEnabled]){
#warning 提示用户打开定位服务
        NSLog(@"没有打开定位服务");
        return -1;
    }
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    switch (authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:{
            CLLocationManager *locationManager =  [[CLLocationManager alloc] init];
            [locationManager startUpdatingLocation];
            [locationManager stopUpdatingLocation];
        }break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"已同意使用");
        }break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:{
            NSLog(@"不可使用");
        }break;
            
        default:
            break;
    }
    return authorizationStatus;
}


/**
 默认的城市对象

 @return 返回长沙的城市对象
 */
- (VPOpenCityInfoModel *)defaultCityModel{
    VPOpenCityInfoModel *cityInfoModel = [[VPOpenCityInfoModel alloc] init];
    cityInfoModel.cityName = @"全国";
    cityInfoModel.vid = @"0";
    return cityInfoModel;
}

#pragma mark - 拼接获取百度地图的URL
+ (NSString *)loadMapImageWith:(NSString *)location size:(CGSize)size{
    CLLocationCoordinate2D locationCoordinate = [QMMapFuntion transformCoordinate:location];
    NSString *locationStr = [NSString stringWithFormat:@"%f,%f",locationCoordinate.longitude,locationCoordinate.latitude];
    NSString *mapImageUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage/v2?ak=%@&mcode=%@&center=%@&width=%f&height=%f&zoom=11&markers=%@&markerStyles=-1,http://api.map.baidu.com/images/marker_red.png&scale=2",BMAP_APPKEY,[InfoPlist buildID],locationStr,size.width,size.height,locationStr];
    return mapImageUrl;
//    http://api.map.baidu.com/staticimage/v2?ak=tdQpg9YCvQELvz5NeaSNiI0i&mcode=com.qineng.villageplay&center=113.196216,28.359471&width=300&height=200&zoom=11&markers=113.196216,28.359471
//http://api.map.baidu.com/staticimage/v2?ak=mKHd6L5184pkx6WnKDpPca96U0LvK3Mt&mcode=F3:89:66:3B:17:8E:9D:A0:28:00:53:42:43:AE:EB:69:1E:C3:04:E3;com.cn.qineng.village.tourism.activity&width=668&height=200&zoom=11&center=111.520445,28.621407&markers=111.520445,28.621407&markerStyles=-1,http://api.map.baidu.com/images/marker_red.png&scale=1
}



- (void)dealloc{
    self.locService.delegate = nil;
    self.locService = nil;
    self.locationBlock = nil;
}
@end
