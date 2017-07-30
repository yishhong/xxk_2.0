//
//  VPMapViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMapViewModel.h"

@interface VPMapViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation VPMapViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

@end
