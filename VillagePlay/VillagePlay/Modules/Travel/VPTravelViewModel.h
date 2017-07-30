//
//  VPTravelViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLocationManager.h"

@interface VPTravelViewModel : NSObject

@property (assign, nonatomic) LocationCoordinateType locationType;

/**
 旅游列表

 @param provinceID 省ID
 @param city 城市ID
 @param isSuggest 是否推荐（1是推荐）
 @param type  0 全部 1.今天 2.明天 3.本周末
 @param sortType 排序 0 热门 1 按距离 2 默认
 @param location 经纬度
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelListprovinceID:(NSString *)provinceID city:(NSString *)city isSuggest:(NSString *)isSuggest sortType:(NSString *)sortType location:(NSString *)location tag:(NSString *)tag IsFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;


/**
 返回行数

 @param section 节
 @return NSInteger
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 返回cell

 @param row 行
 @param section 节
 @return XXCellModel
 */
-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
