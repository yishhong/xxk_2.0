//
//  VPSubmitOrderModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSubmitOrderModel.h"
#import "VPTravelAPI.h"
#import "VPWeChatModel.h"
#import "YYModel.h"

@interface VPSubmitOrderModel()

@property(strong, nonatomic)NSMutableArray *dataSource;

@property(strong, nonatomic) VPTravelAPI *travelAPI;

@end

@implementation VPSubmitOrderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.travelAPI =[[VPTravelAPI alloc]init];
    }
    return self;
}

- (void)travelWeChatPay:(NSString *)out_trade_no channelType:(VPChannelType)channelType success:(void (^)(VPWeChatModel *))success failure:(void (^)(NSError *))failure{
    
    NSString * urlString =@"";
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    if (channelType==VPChannelTypeTravel) {
        
        urlString =@"api/ActivityAlipay/PostActivitiesWXpay";
        [params setObject:out_trade_no forKey:@"orderNum"];
    }if (channelType==VPChannelTypeHotel){
        
        urlString =@"api/HomestayOrder/WxPayHotel";
        [params setObject:out_trade_no forKey:@"orderNum"];
        
    }if (channelType==VPChannelTypeTicket){
        urlString =@"api/Ticket/WxPayTicket";
        [params setObject:out_trade_no forKey:@"orderNum"];
    }
    [self.travelAPI travelPaymentParams:params urlstring:urlString success:^(NSDictionary *responseDict) {
        VPWeChatModel * weChatModel =[VPWeChatModel yy_modelWithJSON:responseDict[@"body"]];
        success(weChatModel);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelAlipayOutTradeNo:(NSString *)outTradeNo channelType:(VPChannelType)channelType success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    NSString * urlString =@"";
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    if (channelType==VPChannelTypeTravel) {
        urlString =@"api/ActivityAlipay/Post";
        [params setObject:outTradeNo forKey:@"orderNum"];
    }if (channelType==VPChannelTypeHotel){
        urlString =@"api/HomestayOrder/AliPayHotel";
        [params setObject:outTradeNo forKey:@"orderNum"];
    }if (channelType==VPChannelTypeTicket){
        urlString =@"api/Ticket/AliPayTicket";
        [params setObject:outTradeNo forKey:@"orderNum"];
    }
    [self.travelAPI travelAlipayParams:params urlstring:urlString success:^(NSDictionary *responseDict) {
        NSString *alipayString =responseDict[@"body"];
        success(alipayString);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)payWayModel:(NSArray *)payWayModel{
    //布局
    //支付方式
        XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPSubmitTableViewCell" height:95 dataSource:nil action:nil];
        [self.dataSource addObject:cellModel];
    
    XXCellModel * payWayCellModel = [XXCellModel instantiationWithIdentifier:@"VPPayWayTableViewCell" height:70 dataSource:nil action:nil];
    [self.dataSource addObject:payWayCellModel];
    
    XXCellModel * payCellModel = [XXCellModel instantiationWithIdentifier:@"VPPayTableViewCell" height:50 dataSource:nil action:nil];
    [self.dataSource addObject:payCellModel];
    
    XXCellModel * payCellModel1 = [XXCellModel instantiationWithIdentifier:@"VPPayTableViewCell" height:50 dataSource:nil action:nil];
    [self.dataSource addObject:payCellModel1];
}



-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}

@end
