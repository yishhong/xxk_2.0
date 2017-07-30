//
//  VPHotelOrderViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderViewModel.h"
#import "VPHotelOrderAPI.h"
#import "VPHotelOrderListModel.h"
#import "YYModel.h"
#import "VPHotelOrderDetailAPI.h"
#import "VPUserManager.h"

@interface VPHotelOrderViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic)VPHotelOrderAPI *hotelOrderAPI;

@property (assign, nonatomic) NSInteger pageIndex;

@property (strong ,nonatomic) VPHotelOrderDetailAPI *hotelOrderDetailAPI;

@end

@implementation VPHotelOrderViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.hotelOrderAPI =[[VPHotelOrderAPI alloc]init];
        self.hotelOrderDetailAPI =[[VPHotelOrderDetailAPI alloc]init];
        self.pageIndex=0;
    }
    return self;
}

- (void)hotelOrderType:(NSString *)type key:(NSString *)key isFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{

    if (isFirstLoading) {
        self.pageIndex = 0;
    }
    NSDictionary * params=@{@"type":type,
                            @"userId":[[VPUserManager sharedInstance]xx_userinfoID],
                            @"pageIndex":@(self.pageIndex),
                            @"pageSize":@"20",
                            @"key":key};
    [self.hotelOrderAPI hotelListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageIndex == 0){
            [self.dataSource removeAllObjects];
        }
        NSArray * hotelOrderArray =[NSArray yy_modelArrayWithClass:[VPHotelOrderListModel class] json:responseDict[@"body"]];
        for (VPHotelOrderListModel *hotelOrderListModel in hotelOrderArray) {
            //布局
            //旅游订单列表(订单状态)
            NSString * orderState =[self orderStatus:hotelOrderListModel];
            NSDictionary *orderStatuesInfo =@{@"name":hotelOrderListModel.hotelName?:@"",
                                              @"orderState":orderState};
            XXCellModel * orderTypeCellModel = [XXCellModel instantiationWithIdentifier:@"OrderTypeTableViewCell" height:40 dataSource:orderStatuesInfo action:nil];
            [self.dataSource addObject:orderTypeCellModel];
            
            //订单信息
            XXCellModel * travelOrderCellModel = [XXCellModel instantiationWithIdentifier:@"HotelOrderGoodsTableViewCell" height:100 dataSource:hotelOrderListModel action:nil];
            [self.dataSource addObject:travelOrderCellModel];
            
            XXCellModel * roomNumCellModel = [XXCellModel instantiationWithIdentifier:@"HotelOrderRoomNumTableViewCell" height:35 dataSource:hotelOrderListModel action:nil];
            [self.dataSource addObject:roomNumCellModel];
            //按钮
            CGFloat orderWayHeight;
            if (hotelOrderListModel.orderState==2) {
                orderWayHeight =0;
            }else if (hotelOrderListModel.orderState==3){
            
                orderWayHeight =0;

            }else{
            
                orderWayHeight =44;
            }
            XXCellModel * orderWayCellModel = [XXCellModel instantiationWithIdentifier:@"OrderWayTableViewCell" height:orderWayHeight dataSource:hotelOrderListModel action:nil];
            [self.dataSource addObject:orderWayCellModel];
            
            //空行
            XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
            [self.dataSource addObject:lineCellModel];
        }
        self.pageIndex++;
        success([hotelOrderArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hoteldeleteOrderID:(NSString *)orderid success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSDictionary *params =@{@"orderid":orderid};
    [self.hotelOrderDetailAPI hotelDeleteOrderParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSString *)orderStatus:(VPHotelOrderListModel*)hotelOrderListModel{

    /**
     房间状态(0待付款,1预订取消，2待确认，3等待入住，5已完成（已入住），6已取消退款中，7已取消退款中，8已完成未入住，9已取消已退款)
     */
    NSString *orderStatusString=@"";
    switch (hotelOrderListModel.orderState) {
        case 0:
            orderStatusString =@"待付款";
            break;
        case 1:
            orderStatusString =@"预订取消";
            break;
        case 2:
            orderStatusString =@"待确定";
            break;
        case 3:
            orderStatusString =@"等待入住";
            break;
        case 5:
            orderStatusString =@"已完成(已入住)";
            break;
        case 6|7:
            orderStatusString =@"已取消(退款中)";
            break;
        case 8:
            orderStatusString =@"已完成(未入住)";
            break;
        case 9:
            orderStatusString =@"已取消(已退款)";
            break;
            
        default:
            break;
    }
    return orderStatusString;
    
}

-(NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.dataSource[indexPath.row];
}

@end
