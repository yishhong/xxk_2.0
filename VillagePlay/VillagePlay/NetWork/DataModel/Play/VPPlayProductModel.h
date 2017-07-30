//
//  VPPlayProductModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPPlayProductModel : VPBaseModel

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger pid;



@end
