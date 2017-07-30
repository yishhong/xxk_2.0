//
//  VPTicketOrderViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderViewModel.h"
#import "VPTiketOrderListOrderModel.h"
#import "VPTiketOrderAPI.h"
#import "YYModel.h"
#import "VPUserManager.h"

@interface VPTicketOrderViewModel ()

@property (strong, nonatomic)VPTiketOrderAPI * tiketOrderAPI;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (assign, nonatomic) NSInteger pageNum;

@end

@implementation VPTicketOrderViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.tiketOrderAPI =[[VPTiketOrderAPI alloc]init];
    }
    return self;
}

- (void)ticketOrderListType:(NSString *)type isFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{

    if (isFirstLoading) {
        self.pageNum=1;
    }
    NSDictionary * params =@{@"type":type,
                             @"userid":[[VPUserManager sharedInstance]xx_userinfoID],
                             @"pageNum":@(self.pageNum),
                             @"pageSize":@"20"};
    [self.tiketOrderAPI trketOrderListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageNum ==1){
            [self.dataSource removeAllObjects];
        }
        NSArray * tiketOrderArray =[NSArray yy_modelArrayWithClass:[VPTiketOrderListOrderModel class] json:responseDict[@"body"]];
        for (VPTiketOrderListOrderModel *tiketOrderListOrderModel in tiketOrderArray) {
            //布局
            //门票订单列表(订单状态)
            NSDictionary * orderStateInfo =[self orderStatus:tiketOrderListOrderModel.orderStatus refundState:tiketOrderListOrderModel.refundState];
            if (orderStateInfo) {
                NSMutableDictionary *orderStateInfoOrder =[NSMutableDictionary dictionary];
                [orderStateInfoOrder setValue:tiketOrderListOrderModel.ticketName forKey:@"name"];
                [orderStateInfoOrder setValue:@(tiketOrderListOrderModel.ceID) forKey:@"ceid"];
                [orderStateInfoOrder setValue:orderStateInfo[@"orderStatus"] forKey:@"orderState"];
                XXCellModel * orderTypeCellModel = [XXCellModel instantiationWithIdentifier:@"OrderTypeTableViewCell" height:40 dataSource:orderStateInfoOrder action:nil];
                [self.dataSource addObject:orderTypeCellModel];
            }
            //订单信息
            NSDictionary *travelOrderInfo =@{@"homePicture":tiketOrderListOrderModel.homePicture,
                                             @"joinDate":tiketOrderListOrderModel.joinDate?tiketOrderListOrderModel.joinDate:@"",
                                             @"orderNum":[NSString stringWithFormat:@"%zd",tiketOrderListOrderModel.ticketCount],
                                             @"price":@(tiketOrderListOrderModel.price)?@(tiketOrderListOrderModel.price):@"",
                                             @"billType":[NSString stringWithFormat:@"%ld",(long)tiketOrderListOrderModel.billType],
                                             @"billBeginDate":tiketOrderListOrderModel.billBeginDate?tiketOrderListOrderModel.billBeginDate:@"",
                                             @"roomType":@"",
                                             @"billEndDate":tiketOrderListOrderModel.billEndDate?tiketOrderListOrderModel.billEndDate:@"",
                                             @"ceid":tiketOrderListOrderModel.orderNum};
            XXCellModel * travelOrderCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderTableViewCell" height:100 dataSource:travelOrderInfo action:nil];
            [self.dataSource addObject:travelOrderCellModel];
            
            
            if (tiketOrderListOrderModel.orderStatus==1) {
                XXCellModel * orderWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelBarcodeTableViewCell" height:44 dataSource:@"请凭二维码/订单号去景区兑票" action:nil];
                [self.dataSource addObject:orderWayCellModel];
                
            }else{
                //按钮
                NSDictionary * orderWayInfo =@{@"orderStateInfo":orderStateInfo,
                                               @"travelOrderListModel":tiketOrderListOrderModel,
                                               @"orderStatus":[NSString stringWithFormat:@"%ld",(long)tiketOrderListOrderModel.orderStatus]};
                XXCellModel * orderWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderWayTableViewCell" height:44 dataSource:orderWayInfo action:nil];
                [self.dataSource addObject:orderWayCellModel];
            }
            XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
            [self.dataSource addObject:lineCellModel];
        }
        self.pageNum++;
        success([tiketOrderArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSDictionary *)orderStatus:(NSInteger)orderState refundState:(NSInteger)refundState{
    
    /**
     
     //    0 待付款 1 待出行 2 预订取消 3 退款 4已完成 -1全部
     //退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
     
     */
    NSDictionary *orderStatusInfo=[NSDictionary dictionary];
    switch (orderState) {

        case 0:
            orderStatusInfo =[self orderStatus:@"待付款" placeString:@"" payString:@"立即支付"];
            
            break;
        case 1:
            orderStatusInfo =[self orderStatus:@"待出行" placeString:@"" payString:@""];
            
            break;
        case 2:
            orderStatusInfo =[self orderStatus:@"预订取消" placeString:@"" payString:@"再次预订"];

            break;
        case 3:
            if (refundState==1||refundState==0) {
                
                orderStatusInfo =[self orderStatus:@"(已取消)退款中" placeString:@"" payString:@"退款详情"];
                
            }else if (refundState==2){
                
                orderStatusInfo =[self orderStatus:@"(已取消)已退款" placeString:@"" payString:@"退款详情"];
            }
            break;
        case 4:
            orderStatusInfo =[self orderStatus:@"已完成" placeString:@"" payString:@"再次预订"];
            break;
        default:
            break;
    }
    return orderStatusInfo;
}

- (NSDictionary *)orderStatus:(NSString *)orderStatus placeString:(NSString *)placeString payString:(NSString *)payString{
    
    NSDictionary *orderStatusInfo=@{@"orderStatus":orderStatus,
                                    @"placeString":placeString,
                                    @"payString":payString};
    return orderStatusInfo;
}

-(NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.dataSource[indexPath.row];
}


@end
