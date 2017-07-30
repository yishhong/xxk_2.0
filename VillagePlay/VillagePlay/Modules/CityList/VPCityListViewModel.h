//
//  VPCityListViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLocationManager.h"

@interface VPCityListViewModel : NSObject

/**
 那个模块的定位
 */
@property (nonatomic, assign) LocationCoordinateType locationType;

/**
 加载开通城市列表数据
 
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)loadDataSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 布局界面
 */
- (void)layerUI;

/**
 返回tableView的索引

 @return 返回索引的数组
 */
- (NSArray *)sectionIndexTitles;

/**
 获取索引的title

 @param section 坐标
 @return 返回索引的title
 */
- (NSString *)sectionIndexTitleWithSection:(NSInteger)section;

/**
 返回Sections

 @return 返回Section数
 */
- (NSInteger)numberOfSections;

/**
 返回Cell数目

 @param section section坐标
 @return 返回cell数量
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
@end
