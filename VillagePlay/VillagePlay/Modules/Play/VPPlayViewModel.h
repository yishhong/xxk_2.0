//
//  VPPlayViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPPlayViewModel : NSObject

/**
 精选玩法(所有参数都可不传数据)

 @param lineName 线路
 @param title 标题
 @param tag tag标签
 @param orderColumn 排序字段
 @param orderDir 排序方向ASC|DESC
 */
- (void)palyListlineName:(NSString *)lineName title:(NSString *)title tag:(NSString *)tag orderColumn:(NSString *)orderColumn orderDir:(NSString *)orderDir isFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

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


@end
