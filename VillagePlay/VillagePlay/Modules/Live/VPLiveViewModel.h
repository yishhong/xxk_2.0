//
//  VPLiveViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPLiveViewModel : NSObject


/**
 直播列表

 @param isFirstLoading 是否首次刷新
 @param success 成功回调
 @param failure 失败回调
 */
- (void)liveListIsFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;

/**
 节

 @param section <#section description#>
 @return <#return value description#>
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;


/**
 行

 @param row <#row description#>
 @return <#return value description#>
 */
-(XXCellModel *)cellForRow:(NSInteger)row;

@end
