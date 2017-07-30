//
//  VPSubCollectionViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSubCollectionViewModel.h"

@interface VPSubCollectionViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPCollectionRecordManager *collectionRecord;
@end

@implementation VPSubCollectionViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.collectionRecord = [[VPCollectionRecordManager alloc] init];
    }
    return self;
}

- (void)loadData{
    NSArray *collectionRecord = [self.collectionRecord collectionRecordWithType:self.collectionRecordtype];
    
    for (id model in collectionRecord) {
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"Test" height:44 dataSource:model action:nil];
        [self.dataSource addObject:cellModel];
    }
    
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}


@end
