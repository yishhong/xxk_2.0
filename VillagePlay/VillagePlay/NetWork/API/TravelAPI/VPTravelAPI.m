//
//  VPTravelAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelAPI.h"

@implementation VPTravelAPI

- (void)travelListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    [self sendGETAPI:@"api/Activity/GetActiveVList" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelTagsParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Tags/GetTagByChannelId" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelPaymentParams:(NSDictionary *)params urlstring:(NSString *)urlstring success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:urlstring authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelAlipayParams:(NSDictionary *)params urlstring:(NSString *)urlstring success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:urlstring authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
