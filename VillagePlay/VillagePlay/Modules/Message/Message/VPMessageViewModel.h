//
//  VPMessageViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@interface VPMessageViewModel : NSObject

- (void)loadMessageCountWithSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

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
@end
