//
//  VPGeneralWebViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPGeneralWebViewModel.h"

@interface VPGeneralWebViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation VPGeneralWebViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

@end
