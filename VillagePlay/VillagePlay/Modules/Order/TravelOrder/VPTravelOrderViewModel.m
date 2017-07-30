//
//  VPTravelOrderViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderViewModel.h"
#import "VPTravelOrderAPI.h"
#import "VPUserManager.h"
#import "VPTravelOrdersListModel.h"
#import "YYModel.h"

@interface VPTravelOrderViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (assign, nonatomic) NSInteger pageNum;

@property (strong ,nonatomic) VPTravelOrderAPI *travelOrderAPI;

@end

@implementation VPTravelOrderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.travelOrderAPI =[[VPTravelOrderAPI alloc]init];
    }
    return self;
}

- (void)travelOrderListState:(NSString *)state isFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{

    if (isFirstLoading) {
        self.pageNum=1;
    }
    NSDictionary *parameters = @{
                                 @"version":@"v15",
                                 @"userid":[[VPUserManager sharedInstance] xx_userinfoID],
                                 @"state":state,
                                 @"pageNum":@(self.pageNum),
                                 @"pageSize":@"20"
                                 };
    [self.travelOrderAPI travelOrderParams:parameters success:^(NSDictionary *responseDict) {
        if(self.pageNum==1){
            [self.dataSource removeAllObjects];
        }
        NSArray * travelOrderArr =[NSArray yy_modelArrayWithClass:[VPTravelOrdersListModel class] json:responseDict[@"body"]];
        for (VPTravelOrdersListModel * travelOrderListModel in travelOrderArr) {
            //布局
            //旅游订单列表(订单状态)
            NSDictionary *orderStateInfo =[self orderStatus:state refundState:travelOrderListModel.refundState];
            if (orderStateInfo) {
                NSMutableDictionary *orderStateInfoOrder =[NSMutableDictionary dictionary];
                [orderStateInfoOrder setValue:travelOrderListModel.activitieName forKey:@"name"];
                [orderStateInfoOrder setValue:travelOrderListModel.ceID forKey:@"ceid"];
                [orderStateInfoOrder setValue:orderStateInfo[@"orderStatus"] forKey:@"orderState"];
                XXCellModel * orderTypeCellModel = [XXCellModel instantiationWithIdentifier:@"OrderTypeTableViewCell" height:40 dataSource:orderStateInfoOrder action:nil];
                [self.dataSource addObject:orderTypeCellModel];
            }
            
            //订单信息
            NSDictionary *travelOrderInfo =@{@"homePicture":travelOrderListModel.homePicture.length>0?travelOrderListModel.homePicture:@"",
                                             @"joinDate":travelOrderListModel.joinDate?travelOrderListModel.joinDate:@"",
                                            @"orderNum":travelOrderListModel.goodsCount?travelOrderListModel.goodsCount:@"",
                                             @"price":@(travelOrderListModel.totalRealPrice)?@(travelOrderListModel.rechargeMoney):@"",
                                             @"billType":[NSString stringWithFormat:@"%ld",(long)travelOrderListModel.billType],
                                             @"billBeginDate":travelOrderListModel.billBeginDate?travelOrderListModel.billBeginDate:@"",
                                             @"roomType":@"",
                                             @"billEndDate":travelOrderListModel.billEndDate?travelOrderListModel.billEndDate:@"",
                                             @"ceid":travelOrderListModel.ceID};
            XXCellModel * travelOrderCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderTableViewCell" height:100 dataSource:travelOrderInfo action:nil];
            [self.dataSource addObject:travelOrderCellModel];
            
            if ([state isEqualToString:@"1"]) {
                XXCellModel * orderWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelBarcodeTableViewCell" height:44 dataSource:@"凭二维码/订单号参与旅游活动" action:nil];
                [self.dataSource addObject:orderWayCellModel];

            }else{
                //按钮
                NSDictionary * orderWayInfo =@{@"orderStateInfo":orderStateInfo,
                                               @"travelOrderListModel":travelOrderListModel,
                                               @"orderStatus":state};
                XXCellModel * orderWayCellModel = [XXCellModel instantiationWithIdentifier:@"TravelOrderWayTableViewCell" height:44 dataSource:orderWayInfo action:nil];
                [self.dataSource addObject:orderWayCellModel];
            }
            
            XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:travelOrderListModel action:nil];
            [self.dataSource addObject:lineCellModel];
            self.pageNum++;
        }
        success([travelOrderArr count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
- (NSDictionary *)orderStatus:(NSString*)orderState refundState:(NSInteger)refundState{

    /**
        0待付款,4已完成,2已取消,3已退款,1待出行
     //退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】

     */
    NSDictionary *orderStatusInfo=[NSDictionary dictionary];
    switch ([orderState integerValue]) {
        case 0:
            orderStatusInfo =[self orderStatus:@"待付款" placeString:@"" payString:@"立即支付"];

            break;
        case 1:
            orderStatusInfo =[self orderStatus:@"待出行" placeString:@"" payString:@""];

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
