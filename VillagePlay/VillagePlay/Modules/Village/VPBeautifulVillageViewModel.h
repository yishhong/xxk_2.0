//
//  VPBeautifulVillageViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLocationManager.h"

@interface VPBeautifulVillageViewModel : NSObject

@property (assign, nonatomic) LocationCoordinateType locationType;


/**
 是否精选 2为精选
 */
@property (assign, nonatomic) NSInteger type;


/**
 tag列表(左边数组数据)

 @param success 成功回调
 @param failure 失败回调
 */
- (void)villageTagListSuccess:(void(^)(NSArray *tags))success failure:(void(^)(NSError * error))failure;

/**
 乡村列表

 @param isFirst 是否首次加载
 @param success 成功回调
 @param failure 失败回调
 */
- (void)villageListWithIsFirst:(BOOL)isFirst success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

/**
 *  返回Cell行数
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取cell的详细信息
 *
 *  @param row     row坐标
 *  @param section section坐标
 *
 *  @return 返回指定的cell的详细信息
 */

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;


/**
 tag刷新
 
 @param tagName tag名
 */
- (void)villageTagName:(NSString *)tagName;

/**
 排序
 @param sortType 排序 0 热门 1 按距离 2 默认
 */
-(void)sortType:(NSInteger)sortType;

@end
