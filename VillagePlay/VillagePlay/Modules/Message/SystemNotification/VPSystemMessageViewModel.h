//
//  VPSystemNotificationModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPSystemMessageViewModel : NSObject

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
 加载系统消息

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSystemNotificationWithSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

@end
