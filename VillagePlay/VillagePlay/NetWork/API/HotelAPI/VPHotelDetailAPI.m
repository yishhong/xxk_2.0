//
//  VPHotelDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelDetailAPI.h"

@implementation VPHotelDetailAPI

- (void)hotelDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    [self sendGETAPI:@"api/Homestay/Getprivate_hotel_infoByhid" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)hotelRoomListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayRoom/Getprivate_hotel_room" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)hotelFacilityListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayInfrastructure/Getprivate_hotel_dictionary" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelPriceParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayRoomPrice/Getprivate_hotel_priceForDay" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelRuleParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/HomestayRoom/GetSetTimedCancellation" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelUpOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/HomestayOrder/Postprivate_hotel_order" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
