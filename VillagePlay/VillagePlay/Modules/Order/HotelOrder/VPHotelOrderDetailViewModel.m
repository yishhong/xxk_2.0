//
//  VPHotelOrderDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderDetailViewModel.h"
#import "HotelOrderInformationTableViewCell.h"
#import "VPHotelOrderDetailAPI.h"
#import "VPHotelOrderDetailModel.h"
#import "YYModel.h"
#import "VPHotelDetailAPI.h"
#import "NSString+Size.h"
#import "NSMutableAttributedString+AttributedString.h"

@interface VPHotelOrderDetailViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPHotelOrderDetailAPI *hotelOrderDetailAPI;

@property (strong, nonatomic) VPHotelOrderDetailModel *hotelOrderDetailModel;

@property (strong, nonatomic) VPHotelDetailAPI *hotelDetailAPI;

@end

@implementation VPHotelOrderDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.hotelOrderDetailAPI =[[VPHotelOrderDetailAPI alloc]init];
        self.hotelDetailAPI =[[VPHotelDetailAPI alloc]init];
    }
    return self;
}

- (void)hotelDetailOrderid:(NSString *)orderid success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params =@{@"orderid":orderid};
    [self.dataSource removeAllObjects];
    [self.hotelOrderDetailAPI hotelOrderDetailParams:params success:^(NSDictionary *responseDict) {
        self.hotelOrderDetailModel =[VPHotelOrderDetailModel yy_modelWithJSON:responseDict[@"body"]];
        
        NSArray * sectionArray =@[@{@"image":@"vp_order_icon_home",
                                    @"title":self.hotelOrderDetailModel.hotelName},
                                  @{@"image":@"vp_order_icon_write",
                                    @"title":[NSString stringWithFormat:@"%@   %@",self.hotelOrderDetailModel.linkRealName?:@"", self.hotelOrderDetailModel.linkPhone?:@""]}];
        //布局
        //空行
        XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        //民宿详情列表(订单状态)
        NSMutableDictionary * orderStateStringInfo =[self orderStatus:self.hotelOrderDetailModel];
        NSDictionary * orderStateInfo =@{@"orderNum":[NSString stringWithFormat:@"订单号:%@",self.hotelOrderDetailModel.orderNum],
            @"orderState":orderStateStringInfo[@"orderStatusString"]};
        XXCellModel * orderTypeCellModel = [XXCellModel instantiationWithIdentifier:@"HotelOrderIDTableViewCell" height:42 dataSource:orderStateInfo action:nil];
        [self.dataSource addObject:orderTypeCellModel];
        
        XXCellModel * lineCellModel2 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel2];
        
        //订单类型
        XXCellModel * orderNameCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderNameTableViewCell" height:41 dataSource:sectionArray[0] action:nil];
        [self.dataSource addObject:orderNameCellModel];
        
        NSDictionary *travelOrderInfo =@{
                                         @"homePicture":self.hotelOrderDetailModel.roomImg?:@"",
                                         @"joinDate":self.hotelOrderDetailModel.hotelName?:@"",
                                         @"orderNum":@"",
                                         @"roomType":self.hotelOrderDetailModel.bedInfo?:@"",
                                         @"price":@(self.hotelOrderDetailModel.price)?:@"",
                                         @"billType":@"",
                                         @"billBeginDate":@"",
                                         @"billEndDate":@""};
        XXCellModel * travelTicketCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderTableViewCell" height:100 dataSource:travelOrderInfo action:nil];
        [self.dataSource addObject:travelTicketCellModel];
        
        //地址
        XXCellModel * partakeWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPartakeWayTableViewCell" height:41 dataSource:@{@"address":[NSString stringWithFormat:@"地址:%@",self.hotelOrderDetailModel.address]} action:nil];
        [self.dataSource addObject:partakeWayCellModel];
        
        //空行
        XXCellModel * lineCellModel3 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel3];
        
        //下单人信息
        XXCellModel * orderNameCellModel1 = [XXCellModel instantiationWithIdentifier:@"TravelOrderNameTableViewCell" height:41 dataSource:sectionArray[1] action:nil];
        [self.dataSource addObject:orderNameCellModel1];
        
        XXCellModel * orderInformationCellModel = [XXCellModel instantiationWithIdentifier:@"HotelOrderInformationTableViewCell" height:120 dataSource:self.hotelOrderDetailModel action:nil];
        [self.dataSource addObject:orderInformationCellModel];
        
        //空行
        XXCellModel * lineCellModel4 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel4];
        NSDictionary * params=@{@"type":@(self.hotelOrderDetailModel.ruleid)};
        [self.hotelDetailAPI hotelRuleParams:params success:^(NSDictionary *responseDict) {
            
            NSString * ruleString=responseDict[@"body"];
            //取消类型(限时取消，不可取消)
            NSDictionary *cancelInfo =@{@"ruleString":ruleString?:@"",
                                        @"ruleid":@(self.hotelOrderDetailModel.ruleid)?:@""};
            
            CGFloat cancelHeight =[ruleString heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-(34+15)];
            cancelHeight+=15+13+13+16;
            XXCellModel * cancelTypeCellModel = [XXCellModel instantiationWithIdentifier:@"HotelCancelTypeTableViewCell" height:cancelHeight dataSource:cancelInfo action:nil];
            [self.dataSource addObject:cancelTypeCellModel];
            
            //空行
            XXCellModel * lineCellModel5 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
            [self.dataSource addObject:lineCellModel5];
            
            //付款信息
            XXCellModel * payWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelPayWayTableViewCell" height:125 dataSource:@{@"payWay":self.hotelOrderDetailModel.payType,                                                                                                                  @"couponPrice":[NSString stringWithFormat:@"￥%.2f",self.hotelOrderDetailModel.discountMoney],
                             @"price":[NSString stringWithFormat:@"￥%.2f",self.hotelOrderDetailModel.price],
                             @"payTime":[NSString stringWithFormat:@"下单时间:%@",self.hotelOrderDetailModel.enterDataTime]} action:nil];
            [self.dataSource addObject:payWayCellModel];
            success();
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelCancelOrderID:(NSString *)orderid success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params =@{@"orderid":orderid};
    [self.hotelOrderDetailAPI hotelCancelOrderParams:params success:^(NSDictionary *responseDict) {
        success();
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

- (NSMutableDictionary *)orderStatus:(VPHotelOrderDetailModel*)hotelOrderDetailModel{
    
    /**
     房间状态(0待付款,1预订取消，2待确认，3等待入住，5已完成（已入住），6已取消退款中，7已取消退款中，8已完成未入住，9已取消已退款)
     */
    NSMutableDictionary * orderStatus =[NSMutableDictionary dictionary];
    NSString *orderStatusString=@"";
    switch (hotelOrderDetailModel.orderState) {
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
    [orderStatus setValue:orderStatusString forKey:@"orderStatusString"];
    return orderStatus;
    
}


- (VPHotelOrderDetailModel *)orederDetailModel{

    return self.hotelOrderDetailModel;
}

- (NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.dataSource[indexPath.row];
}

- (NSString *)deleteButtonString:(VPHotelOrderDetailModel *)hotelOrderDetailModel{

    NSString *deleteButtonString=@"";
    switch (hotelOrderDetailModel.orderState) {
        case 0:
            deleteButtonString=@"立即支付";
            break;
        case 1:
            deleteButtonString=@"删除订单";
            break;
        case 2:
            NSLog(@"取消订单");
            deleteButtonString=@"取消订单";

            break;
        case 3:
            deleteButtonString=@"取消订单";
            NSLog(@"取消订单");
            break;
        case 5:
            deleteButtonString=@"再次预订";

            break;
        case 6|7:
            deleteButtonString=@"退款详情";
            NSLog(@"退款详情");
            break;
        case 8:
            NSLog(@"再次预订");
            deleteButtonString=@"再次预订";

            break;
        case 9:
            NSLog(@"退款详情");
            deleteButtonString=@"退款详情";
            break;
        default:
            break;
    }
    return deleteButtonString;
}

-(NSString *)subscribeButtonString:(VPHotelOrderDetailModel *)hotelOrderDetailModel{

    NSString *subscribeButtonString=@"";
    switch (hotelOrderDetailModel.orderState) {
        case 0:
            subscribeButtonString=@"取消订单";
            break;
            
        case 1:
            subscribeButtonString=@"再次预订";
            break;
        default:
            break;
    }
    return subscribeButtonString;
}

- (NSMutableDictionary *)refundString:(VPHotelOrderDetailModel *)hotelOrderDetailModel{

    NSString *refundString =@"";
    NSString *deductionsString =@"";
    NSMutableAttributedString *attributedRefundString=[[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *attributedDeductionsString=[[NSMutableAttributedString alloc]init];
    switch (hotelOrderDetailModel.orderState) {
        case 6|7:
            refundString =[NSString stringWithFormat:@"退款￥%.2f",hotelOrderDetailModel.returnMoney];
            deductionsString =[NSString stringWithFormat:@"扣款￥%.2f",hotelOrderDetailModel.returnDebitMoeny];
            break;
        case 9:
            refundString =[NSString stringWithFormat:@"退款￥%.2f",hotelOrderDetailModel.returnMoney];
            deductionsString =[NSString stringWithFormat:@"扣款￥%.2f",hotelOrderDetailModel.returnDebitMoeny];
            break;
        default:
            break;
    }
   attributedRefundString= [attributedRefundString rangeAttributedString:refundString changeColorString:[NSString stringWithFormat:@"￥%.2f",hotelOrderDetailModel.returnMoney]];
    attributedDeductionsString =[attributedDeductionsString rangeAttributedString:deductionsString changeColorString:[NSString stringWithFormat:@"￥%.2f",hotelOrderDetailModel.returnDebitMoeny]];
    NSMutableDictionary * moneyInfo =[NSMutableDictionary dictionary];
    [moneyInfo setObject:refundString forKey:@"refundString"];
    [moneyInfo setObject:deductionsString forKey:@"deductionsString"];
    [moneyInfo setObject:attributedRefundString forKey:@"attributedRefundString"];
    [moneyInfo setObject:attributedDeductionsString forKey:@"attributedDeductionsString"];
    return moneyInfo;
}

@end
