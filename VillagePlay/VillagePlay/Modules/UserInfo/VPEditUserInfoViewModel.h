//
//  VPEditUserInfoViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPUserManager.h"

@interface VPEditUserInfoViewModel : NSObject

@property (nonatomic, strong) VPUserInfoModel *userModel;


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
 更新用户信息

 @param success 成功回调
 @param failure 失败回调
 */
- (void)updateUserInfoSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 加载用户信息

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadUserInfoSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;

- (void)key:(NSString *)key value:(NSString *)value;

/**
 选中的头像

 @param photoImage 当前选中的图片
 */
- (void)selectPhotoImage:(UIImage *)photoImage;
@end
