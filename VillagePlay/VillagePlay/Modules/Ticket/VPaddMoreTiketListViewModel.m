//
//  VPaddMoreTiketListViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPaddMoreTiketListViewModel.h"
#import "VPActivityGoodsModel.h"

@interface VPaddMoreTiketListViewModel ()

@property(strong, nonatomic)NSMutableArray *dataSource;

@end

@implementation VPaddMoreTiketListViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

-(void)tiketAddMoreTiketListModel:(NSArray *)addMoreTiketListModel{
    
    for (VPActivityGoodsModel *activityGoodsModel in addMoreTiketListModel) {
        if (activityGoodsModel.type ==2) {
            //布局
            //专题列表
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPTicketReservationTableViewCell" height:91 dataSource:activityGoodsModel action:nil];
            [self.dataSource addObject:cellModel];
        }
    }
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}

@end
