//
//  VPCouponController.hController
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//



#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"

@interface VPCouponController : VPBaseViewController

+ (instancetype)instantiation;

/**
 订单状态
 */
@property (nonatomic, assign) CouponUseState state;

@end
