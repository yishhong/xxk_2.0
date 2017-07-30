//
//  VPTicketOrderDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderDetailViewModel.h"
#import "VPTiketOrderAPI.h"
#import "VPUserManager.h"
#import "YYModel.h"
#import "XXCellModel.h"
#import "VPTiketOrderDetailOrderModel.h"
#import "NSMutableAttributedString+AttributedString.h"

@interface VPTicketOrderDetailViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPTiketOrderAPI *ticketOrderAPI;

@property (strong, nonatomic) VPTiketOrderDetailOrderModel *tiketOrderDetailOrderModel;

@end

@implementation VPTicketOrderDetailViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.ticketOrderAPI =[[VPTiketOrderAPI alloc]init];
    }
    return self;
}

- (void)ticketOrderDetailOrderNum:(NSString *)orderNum success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params =@{@"userid":[[VPUserManager sharedInstance]xx_userinfoID],
                                @"orderNum":orderNum};
    [self.ticketOrderAPI trketOrderDetailParams:params success:^(NSDictionary *responseDict) {
        [self.dataSource removeAllObjects];
        self.tiketOrderDetailOrderModel =[VPTiketOrderDetailOrderModel yy_modelWithJSON:responseDict[@"body"]];
        VPTicketRegisteRecord * ticketRegisteRecord =[self.tiketOrderDetailOrderModel.ticketRegisteRecord firstObject];
        
        //布局
        //空行
        XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        //旅游详情列表(订单状态)
        NSDictionary * orderStateInfo =[self orderStatus:ticketRegisteRecord.isAccept refundState:ticketRegisteRecord.refundState];
        NSString * orderStateString=orderStateInfo[@"orderStatus"];
        NSMutableDictionary * hotelOrderStateInfo =[NSMutableDictionary dictionary];
        if (orderStateString.length>0) {
            [hotelOrderStateInfo setValue:orderStateString forKey:@"orderState"];
        }
        [hotelOrderStateInfo setValue:[NSString stringWithFormat:@"订单号:%@",ticketRegisteRecord.orderNum] forKey:@"orderNum"];
        XXCellModel * orderTypeCellModel = [XXCellModel instantiationWithIdentifier:@"HotelOrderIDTableViewCell" height:42 dataSource:hotelOrderStateInfo action:nil];
        [self.dataSource addObject:orderTypeCellModel];
        
        XXCellModel * lineCellModel2 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel2];
        
        //订单类型
        XXCellModel * orderNameCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderNameTableViewCell" height:41 dataSource:@{@"image":@"vp_order_icon_flage",
                                                                                                                                           @"title":ticketRegisteRecord.ticketName} action:nil];
        [self.dataSource addObject:orderNameCellModel];
        
        for (VPTicketGoods *ticketGoods in self.tiketOrderDetailOrderModel.ticketGoods) {
            XXCellModel * travelTicketCellModel = [XXCellModel instantiationWithIdentifier:@"TravelTicketTypeTableViewCell" height:84 dataSource:@{@"goods":ticketGoods.title,
                                                                                                                                                   @"time":[NSString stringWithFormat:@"使用时间:%@",ticketRegisteRecord.rechargeDate],
                                                                                                                                                   @"number":[NSString stringWithFormat:@"购买数量:%zd",ticketGoods.goodsNum]} action:nil];
            [self.dataSource addObject:travelTicketCellModel];
        }
//        XXCellModel * partakeWayAddressCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPartakeWayTableViewCell" height:41 dataSource:@{@"address":@"景点地址:凭二维码/订单号参与旅游活动"} action:nil];
//        [self.dataSource addObject:partakeWayAddressCellModel];
        //参与方式
        XXCellModel * partakeWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPartakeWayTableViewCell" height:41 dataSource:@{@"address":@"入园方式:凭二维码/订单号参与旅游活动"} action:nil];
        [self.dataSource addObject:partakeWayCellModel];
        
        //空行
        XXCellModel * lineCellModel3 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel3];
        
//        预订人信息
        XXCellModel * reservationPeopleCellModel = [XXCellModel instantiationWithIdentifier:@"TravelReservationPeopleTableViewCell" height:101 dataSource:@{@"image":@"vp_order_icon_home",
                                                                                                                                                            @"title":@"预订人",
                                                                                                                                                            @"name":[NSString stringWithFormat:@"姓  名:%@",ticketRegisteRecord.ceName],
                                                                                                                                                            @"phoneNumber":[NSString stringWithFormat:@"联系电话:%@",ticketRegisteRecord.phoneNumber],                                                        @"orderState":[NSString stringWithFormat:@"%ld",(long)ticketRegisteRecord.isAccept],
                                                                                                                                                            @"order":ticketRegisteRecord.orderNum} action:nil];
        [self.dataSource addObject:reservationPeopleCellModel];
        [self.dataSource addObject:lineCellModel];
        //付款信息
        XXCellModel * payWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPayWayTableViewCell" height:125 dataSource:@{@"payWay":[NSString stringWithFormat:@"%@",@"在线支付"],
                                                                                                                                      @"couponPrice":[NSString stringWithFormat:@"￥%.2f",ticketRegisteRecord.discountMoney],
                                                                                                                                      @"price":[NSString stringWithFormat:@"￥%.2f",ticketRegisteRecord.rechargeMoney],
                                                                                                                                      @"payTime":[NSString stringWithFormat:@"下单时间:%@",ticketRegisteRecord.rechargeDate]} action:nil];
        [self.dataSource addObject:payWayCellModel];
        success();
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
            orderStatusInfo =[self orderStatus:@"待出行" placeString:@"" payString:@"申请退款"];
            
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

- (NSMutableDictionary *)refundString:(VPTiketOrderDetailOrderModel *)travelOrderDetailModel{
    
    VPTicketRegisteRecord *ticketRegisteRecord =[travelOrderDetailModel.ticketRegisteRecord firstObject];
    
    NSString *refundString =@"";
    NSMutableAttributedString *attributedRefundString=[[NSMutableAttributedString alloc]init];
    NSMutableDictionary * moneyInfo =[NSMutableDictionary dictionary];
    switch (ticketRegisteRecord.isAccept) {
        case 0:
            refundString =[NSString stringWithFormat:@"下单30分钟内未完成支付,订单自动取消"];
            attributedRefundString= [attributedRefundString changeColorString:refundString location:2 length:3];
            break;
        case 3:
            refundString =[NSString stringWithFormat:@"退款%.2f",ticketRegisteRecord.rechargeMoney];
            attributedRefundString= [attributedRefundString rangeAttributedString:refundString changeColorString:[NSString stringWithFormat:@"￥%.2f",ticketRegisteRecord.rechargeMoney]];
            break;
    }
    [moneyInfo setObject:refundString forKey:@"refundString"];
    [moneyInfo setObject:attributedRefundString forKey:@"attributedRefundString"];
    return moneyInfo;
}

- (void)ticketOrderCancelOrderNum:(NSString *)orderNum success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary * params=@{@"orderNum":orderNum};
    [self.ticketOrderAPI tiketCancelOrderParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)ticketRefundOrderNum:(NSString *)orderNum success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary * params=@{@"OrderNum":orderNum,
                            @"UserID":[[VPUserManager sharedInstance]xx_userinfoID],
                            @"RefundReason":@""};
    [self.ticketOrderAPI tiketRefundOrderParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.dataSource[indexPath.row];
}

- (VPTiketOrderDetailOrderModel *)orderDetailModel{
    
    return self.tiketOrderDetailOrderModel;
}

@end
