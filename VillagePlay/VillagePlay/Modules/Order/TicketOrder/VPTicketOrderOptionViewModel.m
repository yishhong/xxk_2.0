//
//  VPTicketOrderOptionViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderOptionViewModel.h"

@interface VPTicketOrderOptionViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation VPTicketOrderOptionViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

@end
