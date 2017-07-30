//
//  VPSubCollectionController.hController
//  VillagePlay
//
//  Created by Apricot on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPCollectionRecordManager.h"

@interface VPSubCollectionController : VPBaseViewController

+ (instancetype)instantiation;


/**
 收藏的类型
 */
@property (nonatomic, assign) VPChannelType collectionRecordtype;

@end
