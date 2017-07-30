//
//  VPDestinationViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLocationManager.h"

@interface VPDestinationViewModel : NSObject

@property (assign, nonatomic) LocationCoordinateType locationType;

/**
 *  布局UI
 */
- (void)layerUI;


/**
 加载目的地Banner数据

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadDestinationBannerSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 加载玩法数据

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadDestinationPlaySuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 加载活动数据（旅游）

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadDestinationTraveSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 加载民宿的数据

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadDestinationHotelSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 加载村庄的数据

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadDestinationVillageSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  返回section数目
 *
 *  @return cell数量
 */
- (NSInteger)numberOfSections;

/**
 返回cell数目

 @param section section
 @return cell数量
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取指定行的cell
 *
 *  @param indexPath cell的坐标
 *
 *  @return 返回指定行的cellModel
 */
- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 获取今天和明天的时间

 @return 返回字典
 */
- (NSDictionary*)dateTimeInfo;

@end
