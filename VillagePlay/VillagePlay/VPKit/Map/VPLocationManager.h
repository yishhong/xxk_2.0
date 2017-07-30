//
//  VPLocationManager.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#import "QMMapFuntion.h"
#import "VPOpenCityInfoModel.h"
#import "CommentDetaileEnum.h"
typedef enum : NSUInteger {
    LocationCoordinateTypeDestination = -1025,
    LocationCoordinateTypeNow = -1026,//目前所在的城市
    LocationCoordinateTypeHotel  = VPChannelTypeHotel,
    LocationCoordinateTypeTicket = VPChannelTypeTicket,
    LocationCoordinateTypeTravel = VPChannelTypeTravel,
    LocationCoordinateTypeVillage= VPChannelTypeVillage,
} LocationCoordinateType;

typedef void(^LocationBlock)(NSError *error,CLLocationCoordinate2D locationCoordinate);

typedef void(^GeoCodeSearchBlock)(BOOL isSuccee,BMKReverseGeoCodeResult *result);

@interface VPLocationManager : NSObject

+ (instancetype)sharedManager;


/**
 是否定位
 */
@property (nonatomic, assign) BOOL isLocation;

/**
 定位位置，如果没有默认长沙
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;

/**
 当前定位的位置
 */
@property (nonatomic, strong) BMKReverseGeoCodeResult *geoLocation;

/**
 目前开通的城市
 */
@property (nonatomic, strong) VPOpenCityInfoModel *cityModel;


/**
 加载指定类型的开通城市

 @param type 指定类型
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadRealCityListWithType:(LocationCoordinateType)type success:(void(^)(NSArray *cityArray))success failure:(void(^)(NSError * error))failure;


//实时定位
//获取定位信息

//需要分别保存旅游、门票、民宿、村庄以及目的地的位置信息


/**
 获取当前对应模块的选中城市

 @param type 对应模块
 @return 返回城市的Model
 */
- (VPOpenCityInfoModel *)locationCoordinate2DWithType:(LocationCoordinateType)type;

/**
 保存选中的城市数据

 @param type 对应的模型
 @param cityModel 城市的模型
 */
- (void)saveLocationCoordinate2DWithType:(LocationCoordinateType)type cityModel:(VPOpenCityInfoModel *)cityModel;

/**
 注意这里需要在地里获取成功的时候才可以判断

 @param type 对应模块
 @return  返回当前城市的模型
 */
- (VPOpenCityInfoModel *)isOpenCityWithType:(LocationCoordinateType)type;

/**
 是否开通城市

 @param type 对应模型
 @return 返回YES NO
 */
- (BOOL)isOpenCityReturnBoolWithType:(LocationCoordinateType)type;

/**
 开启定位

 @param locationBlock 定位完成的回调
 */
- (void)startLocation:(LocationBlock)locationBlock;


/**
 逆地理位置（经纬度转地址）

 @param CLLocationCoordinate2D 经纬度
 @param geoCodeSearchBlock 回调
 */
- (void)reverseGeoCode:(CLLocationCoordinate2D)CLLocationCoordinate2D block:(GeoCodeSearchBlock)geoCodeSearchBlock;

/**
 通过坐标生成地图图片URL（这个方法可以转移到QMMapFuntion中去）
 
 @param location 坐标地址
 @return 返回地图图片的URL
 */
+ (NSString *)loadMapImageWith:(NSString *)location size:(CGSize)size;

@end
