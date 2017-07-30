//
//  VPPlayDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPPlayDetailViewModel : NSObject

- (NSString *)topImageURL;

/**
 游玩详情

 @param playID 游玩ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)playDetailPlayID:(NSInteger)playID success:(void(^)())success failure:(void(^)(NSError * error))failure;

- (NSInteger)numberOfSections;
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
 获取左边的引导数组

 @return 返回数组
 */
- (NSArray *)leftArray;

/**
 是否显示左边的按钮

 @return YES 显示 NO 不显示
 */
- (BOOL)isShowButton;

@end
