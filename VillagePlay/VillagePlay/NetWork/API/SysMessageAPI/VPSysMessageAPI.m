//
//  VPSysMessageAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSysMessageAPI.h"

@implementation VPSysMessageAPI

- (void)loadSysMessageCountWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/SysMessage/LoadSysMessageCount" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadSysMessageWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/SysMessage/LoadSysMessage" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//- (void)loadSingleSysMessageWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
//    [self sendPOSTAPI:@"api/SysMessage/LoadSingleSysMessage" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
//        success(responseDict);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
@end
