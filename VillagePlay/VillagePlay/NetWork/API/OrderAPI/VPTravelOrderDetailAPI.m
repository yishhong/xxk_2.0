//
//  VPTravelOrderDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderDetailAPI.h"

@implementation VPTravelOrderDetailAPI

- (void)travelOrderDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/MyOrder/GetMyOrderVInfo" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelOrderRefundDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/MyOrder/GetRefundModel" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelRefundParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/MyOrder/Post" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)travelCancelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/Activity/Delete" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
