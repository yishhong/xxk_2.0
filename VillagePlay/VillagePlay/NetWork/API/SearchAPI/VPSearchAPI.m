//
//  VPSearchAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchAPI.h"

@implementation VPSearchAPI

- (void)loadSearchAllWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Search/SearchAll" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadSearchHotelWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Search/SearchHotel" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadSearchActiveWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Search/SearchActive" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadSearchTicketWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Search/SearchTicket" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadSearchVillageWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Search/SearchVillage" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

