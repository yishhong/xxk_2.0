//
//  VPTagsModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPTagModel.h"

@interface VPTagsModel : VPBaseModel

@property(strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray <VPTagModel *>* tags;

@end
