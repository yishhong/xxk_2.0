//
//  VPHotelStatusModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPHotelStatusModel : VPBaseModel

/**
 提交时间
 */
@property(strong, nonatomic) NSString *submitDate;

/**
 支付时间
 */
@property (strong, nonatomic) NSString *payDate;

/**
 确认时间
 */
@property (strong, nonatomic) NSString *checkDate;

/**
 完成时间
 */
@property (strong, nonatomic) NSString *tradeDate;

@end
