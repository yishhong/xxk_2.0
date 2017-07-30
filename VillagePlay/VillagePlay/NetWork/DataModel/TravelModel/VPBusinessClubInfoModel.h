//
//  VPBusinessClubInfoModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPBaseModel.h"


@interface VPBusinessClubInfoModel : VPBaseModel

//俱乐部ID
@property(nonatomic)NSInteger clubID;

//名称
@property(strong,nonatomic)NSString *clubName;

//简介
@property(strong,nonatomic)NSString * clubDes;

//图片地址
@property(strong,nonatomic)NSString * photoUrl;

//星级
@property(nonatomic)NSInteger clubStar;


@end
