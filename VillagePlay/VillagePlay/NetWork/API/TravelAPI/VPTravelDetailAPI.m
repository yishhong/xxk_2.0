//
//  VPTravelDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelDetailAPI.h"

@implementation VPTravelDetailAPI

- (void)travelDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Activity/GetActiveVInfo" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);

    } failure:^(NSError *error) {
        failure(error);
    }];
//    [self sendGETAPI:@"api/Activity/GetActiveVInfo" withParams:params success:^(NSDictionary *responseDict) {
//        success(responseDict);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
}

- (void)travelOrderWritelParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendPOSTAPI:@"api/ActivitySignUp/Post" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
