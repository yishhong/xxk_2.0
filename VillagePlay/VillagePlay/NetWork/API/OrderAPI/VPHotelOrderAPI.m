//
//  VPHotelAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderAPI.h"

@implementation VPHotelOrderAPI

- (void)hotelListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    
    [self sendGETAPI:@"api/HomestayOrder/Getpriveate_hotel_orderListByUserId" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelOrderStateParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayOrder/Getprivate_hotel_OrderStatus" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    [self sendGETAPI:@"api/HomestayOrder/Getprivate_hotel_ReturnOrder" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)travelRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/MyOrder/GetRefundModel" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)ticketRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/Ticket/TicketRefundDetail" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

@end
