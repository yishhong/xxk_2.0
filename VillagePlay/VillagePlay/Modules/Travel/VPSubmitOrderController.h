//
//  VPSubmitOrderController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"

@interface VPSubmitOrderController : VPBaseViewController

+ (instancetype)instantiation;

@property (assign, nonatomic) float price;

@property (strong, nonatomic) NSString * name;

@property (strong, nonatomic) NSString * orderID;

@property (assign, nonatomic) VPChannelType channelType;

@end
