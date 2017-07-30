//
//  VPQiNiuAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"
#import <UIKit/UIKit.h>

@interface VPQiNiuAPI : VPAPI
/**
 *  获取上传图片的token(七牛)
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)uploadImageTokenWithQiNiuSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;
/**
 *  上传图片到七牛
 *
 *  @param imageDatas 图片组
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (void)uploadImageWithImages:(NSArray *)imageDatas Success:(void(^)(NSArray * imageUrlArray))success failure:(void(^)(NSError *error))failure;

@end
