//
//  VPBeautifulVillageDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPVillageDetailModel.h"

@interface VPBeautifulVillageDetailViewModel : NSObject

/**
 乡村详情
 
 @param villageID 乡村ID
 @param userid 用户ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)villageDetailID:(NSString *)villageID success:(void(^)())success failure:(void(^)(NSError * error))failure;

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
 头部图片数据

 @return VPVillageDetailModel
 */
- (VPVillageDetailModel *)detailModel;

@end
