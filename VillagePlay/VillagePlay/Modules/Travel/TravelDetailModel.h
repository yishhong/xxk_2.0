//
//  TravelDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"XXCellModel.h"
#import "VPActiveDetailModel.h"


@interface TravelDetailModel : NSObject


/**
 旅游详情

 @param travelID 旅游ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelDetailID:(NSString *)travelID success:(void(^)())success failure:(void(^)(NSError * error))failure;

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
 数据model

 @return VPActiveDetailModel
 */
-(VPActiveDetailModel *)activeModel;

@end
