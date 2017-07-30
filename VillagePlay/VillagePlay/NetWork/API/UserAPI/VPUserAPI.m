//
//  VPUserAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserAPI.h"

@implementation VPUserAPI

- (void)loadUserInfoWithUserId:(NSString *)userId success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/User/GetUser" authorizationType:QMAuthorizationTypePassword params:@{@"userid":userId} success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)updateUserInfoWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendPOSTAPI:@"api/User/UpdateUserInfo" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success (responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
