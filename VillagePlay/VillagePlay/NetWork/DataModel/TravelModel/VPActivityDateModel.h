//
//  VPActivityDateModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPBaseModel.h"

@interface VPActivityDateModel : VPBaseModel

//日期
@property(strong,nonatomic)NSString * actDate;

//余票
@property(nonatomic) NSInteger tickets;

@end
