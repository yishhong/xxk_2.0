//
//  VPCommendAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommendAPI.h"

@implementation VPCommendAPI

- (void)addCommendWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendPOSTAPI:@"api/Commend/Add" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadCommendListWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Commend/GetCommendList" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadCommentMessageCountWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Commend/LoadCommentMessageCount" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadUserCommendListWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Commend/GetUserCommendList" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)deleteCommendWithCommendID:(NSString *)commendID userID:(NSString *)userID success:(Success)success failure:(Failure)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commendid"] = commendID;
    params[@"userid"] = userID;
    [self sendPOSTAPI:@"api/Commend/RemoveCommend" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
