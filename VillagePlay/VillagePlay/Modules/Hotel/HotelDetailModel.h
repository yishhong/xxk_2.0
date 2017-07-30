//
//  HotelDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPHotelDetailModel.h"
#import "CommentDetaileEnum.h"


@interface HotelDetailModel : NSObject


/**
 民宿详情

 @param hid 民宿id
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelDetailHid:(NSString *)hid infoDate:(NSMutableDictionary *)infoDate success:(void(^)())success failure:(void(^)(NSError * error))failure;


/**
 获取房间列表

 @param hotelID 民宿id
 @param beginTime 开始时间
 @param endTime 结束时间
 @param type 房间类型（-1全部，1已发布，0未发布，2违规下架）
 */
- (void)hotelRoomListHotelID:(NSString *)hotelID beginTime:(NSString *)beginTime endTime:(NSString *)endTime type:(NSString *)type success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 评论列表
 
 @param VillageID 评论当前页ID
 @param commendType 评论类型
 @param isFirstLoading 是否下拉刷新
 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelCommentListVillageID:(NSString *)VillageID commendType:(VPChannelType)commendType success:(void(^)())success failure:(void(^)(NSError * error))failure;

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
 顶部图片

 @return
 */
-(NSArray *)headImageArray;


/**
 民宿信息

 @return <#return value description#>
 */
- (VPHotelDetailModel *)hotelModel;

@end
