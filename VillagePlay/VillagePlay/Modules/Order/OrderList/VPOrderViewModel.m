//
//  VPOrderViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPOrderViewModel.h"

@interface VPOrderViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation VPOrderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)layerUI{
    
    [self.dataSource removeAllObjects];
    //7个
    NSArray *uiArray = @[@{@"icon":@"vp_order_icon_travel",@"title":@"旅游订单",@"event":@"TravelOrder"},
                         @{@"icon":@"vp_order_icon_hotel",@"title":@"民宿订单",@"event":@"HotelOrder"},
                         @{@"icon":@"vp_order_icon_ticket",@"title":@"门票订单",@"event":@"TicketOrder"},
                         ];
    
    for (NSDictionary *cellInfo in uiArray) {
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPOrderCell" height:76 dataSource:cellInfo action:NSSelectorFromString([NSString stringWithFormat:@"go_%@",cellInfo[@"event"]])];
        [self.dataSource addObject:cellModel];
    }
    XXCellModel *cellModel = [self.dataSource lastObject];
    cellModel.location = CellLocationEnd;
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}

@end
