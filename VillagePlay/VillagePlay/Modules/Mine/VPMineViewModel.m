//
//  VPMineViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMineViewModel.h"

@interface VPMineViewModel ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation VPMineViewModel

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
    NSArray *uiArray = @[@{@"icon":@"vp_mine_order",@"title":@"我的订单",@"event":@"order"},
                         @{@"icon":@"vp_mine_coupon",@"title":@"优惠券",@"event":@"coupon"},
#warning 暂时隐藏
//                         @{@"icon":@"vp_mine_collection",@"title":@"我的收藏",@"event":@"collection"},
#warning 会员中心目前隐藏
//                         @{@"icon":@"vp_mine_memberCenter",@"title":@"会员中心",@"event":@"memberCenter"},
                         @{@"icon":@"vp_mine_gift",@"title":@"邀请有奖",@"event":@"gift"},
                         @{@"icon":@"vp_mine_service",@"title":@"联系客服",@"event":@"service"},
                         @{@"icon":@"vp_mine_about",@"title":@"关于我们",@"event":@"about"},
                         ];
    
    for (NSDictionary *cellInfo in uiArray) {
        XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:spaceModel];
        
        XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPMineListCell" height:45 dataSource:cellInfo action:NSSelectorFromString([NSString stringWithFormat:@"go_%@",cellInfo[@"event"]])];
        [self.dataSource addObject:cellModel];
    }
    XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
    [self.dataSource addObject:spaceModel];
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}

@end
