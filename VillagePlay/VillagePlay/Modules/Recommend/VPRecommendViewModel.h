//
//  VPRecommendViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPVersionModel.h"


@interface VPRecommendViewModel : NSObject

@property (strong, readonly,nonatomic) VPVersionModel * versionModel;


/**
 获取当前最新的版本信息

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadVersionSuccess:(void(^)(BOOL isUpdate))success failure:(void(^)(NSError * error))failure;

/**
 加载推荐页面数据

 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)loadDataSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  布局UI
 */
- (void)layerUI;
/**
 *  返回cell数目
 *
 *  @return cell数量
 */
- (NSInteger)numberOfRows;

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
