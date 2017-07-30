//
//  VPHotelRoomListViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPHotelRoomListRoomModel.h"

@interface VPHotelRoomListViewModel : NSObject

/**
 民宿列表
 @param hotelViewModel <#hotelViewModel description#>
 */
-(void)hotelRoomListModel:(VPHotelRoomListRoomModel *)hotelRoomListRoomModel;


/**
 取消规则
 
 @param type 0.不可取消 1.限时取消
 @param success 成功回调
 @param failure 失败回调
 */
-(void)hotelRuleType:(NSString *)type success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 返回节

 @param section 节
 @return NSInteger
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;


/**
 返回每节多少行

 @param row 行
 @param section 节
 @return XXCellModel
 */
-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
