//
//  VPLiveImageTextViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPLiveImageTextViewModel : NSObject

/**
 图文直播

 @param liveId 直播ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)liveDetailLiveId:(NSUInteger)liveId success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 节

 @param section 节
 @return <#return value description#>
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;


/**
 行数

 @param row 行
 @param section 节
 @return <#return value description#>
 */
- (XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
