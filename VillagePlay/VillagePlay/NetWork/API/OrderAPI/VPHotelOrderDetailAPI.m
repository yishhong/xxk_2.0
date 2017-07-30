//
//  VPHotelOrderDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderDetailAPI.h"

@implementation VPHotelOrderDetailAPI

- (void)hotelOrderDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayOrder/Getprivate_hotel_order" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelOrderRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayOrder/Getprivate_hotel_ReturnOrder" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelCancelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/HomestayOrder/PostCancelprivate_hotel_order" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelDeleteOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/HomestayOrder/PostDeleteprivate_hotel_order" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
