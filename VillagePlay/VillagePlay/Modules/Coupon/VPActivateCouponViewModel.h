//
//  VPActivateCouponViewModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSError+Reason.h"

@interface VPActivateCouponViewModel : NSObject

/**
 优惠券码
 */
@property (strong, nonatomic) NSString *couponCode;

/**
 激活优惠券

 @param success 成功回调
 @param failure 失败回调
 */
- (void)activateCouponSuccess:(void(^)())success failure:(void(^)(NSError * error))failure;




@end
