//
//  VPTravelOrderDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderDetailViewModel.h"
#import "VPUserManager.h"
#import "VPTravelOrderDetailAPI.h"
#import "VPTravelOrderDetailModel.h"
#import "YYModel.h"

@interface VPTravelOrderDetailViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPTravelOrderDetailAPI *travelOrderDetailAPI;

@property (strong, nonatomic) VPTravelOrderDetailModel *travelOrderDetailModel;
@end

@implementation VPTravelOrderDetailViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.travelOrderDetailAPI =[[VPTravelOrderDetailAPI alloc]init];
    }
    return self;
}

- (void)travelOrderDetailCeid:(NSString *)ceid type:(NSInteger)type success:(void (^)())success failure:(void (^)(NSError *))failure{

    [self.dataSource removeAllObjects];
    NSDictionary *parameters = @{@"version":@"v15",
                                 @"ceid":ceid,
                                 @"type":@(type)
                                 };
    [self.travelOrderDetailAPI travelOrderDetailParams:parameters success:^(NSDictionary *responseDict) {
        
        self.travelOrderDetailModel =[VPTravelOrderDetailModel yy_modelWithJSON:responseDict[@"body"]];
        //布局
        //空行
        XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        //旅游订单列表(订单状态)
        NSDictionary *orderStateInfo =[self orderStatus:self.travelOrderDetailModel.isAccept refundState:self.travelOrderDetailModel.refundState];
            NSMutableDictionary *orderStateInfoOrder =[NSMutableDictionary dictionary];
        NSString * orderStateString =orderStateInfo[@"orderState"];
        if (orderStateString.length>0) {
            [orderStateInfoOrder setValue:orderStateInfo[@"orderState"] forKey:@"orderState"];
        }
            [orderStateInfoOrder setValue:[NSString stringWithFormat:@"订单号:%@",self.travelOrderDetailModel.orderNum] forKey:@"name"];
            [orderStateInfoOrder setValue:[NSString stringWithFormat:@"%zd",self.travelOrderDetailModel.ceID] forKey:@"ceid"];
            XXCellModel * orderTypeCellModel = [XXCellModel instantiationWithIdentifier:@"OrderTypeTableViewCell" height:40 dataSource:orderStateInfoOrder action:nil];
            [self.dataSource addObject:orderTypeCellModel];
        XXCellModel * lineCellModel2 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel2];
        
        //订单类型
        XXCellModel * orderNameCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderNameTableViewCell" height:41 dataSource:@{@"image":@"vp_order_icon_flage",
                         @"title":self.travelOrderDetailModel.activitieName} action:nil];
        [self.dataSource addObject:orderNameCellModel];
        
        for (VPTravelSubitLstGoods *travelSubitLstGoods in self.travelOrderDetailModel.lstGoods) {
            XXCellModel * travelTicketCellModel = [XXCellModel instantiationWithIdentifier:@"TravelTicketTypeTableViewCell" height:84 dataSource:@{@"goods":travelSubitLstGoods.goodsName,
                                @"time":[NSString stringWithFormat:@"使用时间:%@",self.travelOrderDetailModel.joinDate],
                                @"number":[NSString stringWithFormat:@"购买数量:%@张",travelSubitLstGoods.number]} action:nil];
            [self.dataSource addObject:travelTicketCellModel];
        }
        
        //参与方式
        XXCellModel * partakeWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPartakeWayTableViewCell" height:41 dataSource:@{@"address":@"参与方式:凭二维码/订单号参与旅游活动"} action:nil];
        [self.dataSource addObject:partakeWayCellModel];
        
        //空行
        XXCellModel * lineCellModel3 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel3];
        
        //预订人信息
        XXCellModel * reservationPeopleCellModel = [XXCellModel instantiationWithIdentifier:@"TravelReservationPeopleTableViewCell" height:101 dataSource:@{@"image":@"vp_order_icon_home",
                                    @"title":@"预订人",
                                    @"name":[NSString stringWithFormat:@"姓  名:%@",self.travelOrderDetailModel.cEName],
                                    @"phoneNumber":[NSString stringWithFormat:@"联系电话:%@",self.travelOrderDetailModel.phoneNumber],                                                        @"orderState":[NSString stringWithFormat:@"%ld",(long)self.travelOrderDetailModel.isAccept],
                                    @"order":self.travelOrderDetailModel.orderNum} action:nil];
        [self.dataSource addObject:reservationPeopleCellModel];
        
        if (self.travelOrderDetailModel.idCord.length>0) {
            //身份证
            XXCellModel * travelIDCordCellModel = [XXCellModel instantiationWithIdentifier:@"TravelIDCordTableViewCell" height:26 dataSource:[NSString stringWithFormat:@"身份证:%@",self.travelOrderDetailModel.idCord] action:nil];
            [self.dataSource addObject:travelIDCordCellModel];
        }if (self.travelOrderDetailModel.address.length>0) {
            //地址
            XXCellModel * addressPartakeWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelIDCordTableViewCell" height:26 dataSource:[NSString stringWithFormat:@"地址:%@",self.travelOrderDetailModel.address] action:nil];
            [self.dataSource addObject:addressPartakeWayCellModel];
        }if (self.travelOrderDetailModel.custom.length>0) {
            //自定义
            XXCellModel * customPartakeWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelIDCordTableViewCell" height:26 dataSource:[NSString stringWithFormat:@"%@",self.travelOrderDetailModel.custom] action:nil];
            [self.dataSource addObject:customPartakeWayCellModel];
        }
        
        //空行
        XXCellModel * lineCellModel4 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel4];
        
        //付款信息
        XXCellModel * payWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPayWayTableViewCell" height:125 dataSource:@{@"payWay":[NSString stringWithFormat:@"%@",@"在线支付"],
                         @"couponPrice":[NSString stringWithFormat:@"￥%.2f",self.travelOrderDetailModel.discountMoney],
                         @"price":[NSString stringWithFormat:@"￥%.2f",self.travelOrderDetailModel.rechargeMoney],
                         @"payTime":[NSString stringWithFormat:@"下单时间:%@",self.travelOrderDetailModel.registDate]} action:nil];
        [self.dataSource addObject:payWayCellModel];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelCancelOrderNum:(NSString *)orderNum success:(void (^)())success failure:(void (^)(NSError *))failure{

        NSDictionary *parameters = @{
                                     @"orderNum":orderNum,
                                     @"userid":[[VPUserManager sharedInstance]xx_userinfoID]
                                     };
    [self.travelOrderDetailAPI travelCancelOrderParams:parameters success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)travelRefund:(NSInteger)refundID success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary * parameters = @{
                                  @"refundID":@(refundID),
                                  @"version":@"v14"
                                  };
    [self.travelOrderDetailAPI travelOrderRefundDetailParams:parameters success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSDictionary *)orderStatus:(NSInteger)orderState refundState:(NSInteger)refundState{
    
    /**
     0待付款,4已完成,2已取消,3已退款,1待出行
     //退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
     
     */
    NSDictionary *orderStatusInfo=[NSDictionary dictionary];
    switch (orderState) {
        case 0:
            orderStatusInfo =[self orderStatus:@"待付款" placeString:@"取消订单" payString:@"立即支付"];
            
            break;
        case 1:
            orderStatusInfo =[self orderStatus:@"待出行" placeString:@"" payString:@"申请退款"];
            
            break;
        case 2:
            orderStatusInfo =[self orderStatus:@"已取消" placeString:@"" payString:@"再次预订"];
            
            break;
        case 3:
            if (refundState==1||refundState==0) {
                
                orderStatusInfo =[self orderStatus:@"退款中" placeString:@"" payString:@"退款详情"];
                
            }else if (refundState==2){
                
                orderStatusInfo =[self orderStatus:@"已退款" placeString:@"" payString:@"退款详情"];
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

- (NSString *)refundString:(VPTravelOrderDetailModel *)travelOrderDetailModel{
    
    NSString *refundString =@"";
    switch (travelOrderDetailModel.isAccept) {
        case 0:
            refundString =[NSString stringWithFormat:@"下单30分钟内未完成支付,订单自动取消"];
            break;
    }
    return refundString;
}

- (NSDictionary *)orderStatus:(NSString *)orderStatus placeString:(NSString *)placeString payString:(NSString *)payString{
    
    NSDictionary *orderStatusInfo=@{@"orderState":orderStatus,
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

- (VPTravelOrderDetailModel *)orderDetailModel{

    return self.travelOrderDetailModel;
}

@end
