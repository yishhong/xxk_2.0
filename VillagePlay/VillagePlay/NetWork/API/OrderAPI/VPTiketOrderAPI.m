//
//  VPTiketOrderAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTiketOrderAPI.h"

@implementation VPTiketOrderAPI

- (void)trketOrderListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Ticket/GetTickListByUserid" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)trketOrderDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Ticket/GetMyOrderByOrderid" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)tiketCancelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/Ticket/CancelTicketOrder" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)tiketRefundOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/Ticket/TicketRefund" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
