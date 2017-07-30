//
//  VPCouponViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "CommentDetaileEnum.h"

@interface VPCouponViewModel : NSObject

@property (nonatomic, assign) CouponUseState state;

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
 获取优惠券的列表

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadCouponListSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

@end
