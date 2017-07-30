//
//  VPSettingViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "SDImageCache.h"

@interface VPSettingViewModel : NSObject

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
 获取缓存大小

 @return 返回缓存的字符串
 */
- (NSString *)cacheSize;

- (void)updateCellModelForRowIndexPath:(NSIndexPath *)indexPath value:(id)value;
@end
