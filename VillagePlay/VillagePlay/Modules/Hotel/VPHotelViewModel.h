//
//  VPHotelViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLocationManager.h"
@interface VPHotelViewModel : NSObject

@property (assign, nonatomic) LocationCoordinateType locationType;


/**
 民宿列表

 @param city 城市
 @param lon 经度
 @param lat 纬度
 @param startPrice 开始价格
 @param endPrice 结束价格
 @param orderByType 0默认排序，1价格由低到高，2距离排序
 @param success 成功回调
 @param failure 失败回调
 */
-(void)hotelListIsFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

/**
 行数

 @param section 节
 @return NSInteger
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;


/**
 每节多少行

 @param row 行
 @param section 节
 @return XXCellModel
 */
-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

/**
 返回今天明天数据字典

 @return 
 */
- (NSDictionary*)dateTimeInfo;

/**
 tag菜单
 
 @param startPrice 开始价格
 @param endPrice 结束价格
 */
- (void)hotelStartPrice:(double)hotelStartPrice hotelEndPrice:(double)hotelEndPrice;
/**
 排序
 @param orderByType 0默认排序，1价格由低到高，2距离排序
 */
- (void)orderByType:(NSInteger)orderByType;


@end
