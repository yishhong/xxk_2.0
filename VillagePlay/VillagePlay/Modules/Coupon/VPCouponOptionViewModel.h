//
//  VPCouponOptionViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPCouponOptionViewModel : NSObject


/**
 获取各个优惠券的数量

 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadCouponCountSuccess:(void(^)(NSDictionary *dict))success failure:(void(^)(NSError * error))failure;

@end
