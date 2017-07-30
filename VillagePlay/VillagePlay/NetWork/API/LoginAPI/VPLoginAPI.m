//
//  VPLoginAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLoginAPI.h"

@implementation VPLoginAPI

- (void)loginAccountWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
//    NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
//    [parameters setObject:userName forKey:@"UserName"];
//    [parameters setObject:pwd forKey:@"Pwd"];
//    [parameters setObject:location?:@"" forKey:@"location"];
    [self sendPOSTAPI:@"api/Login/Login" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loginOthertWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
//    NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
//    [parameters setObject:openid forKey:@"openid"];
//    [parameters setObject:unionid forKey:@"unionid"];
    [self sendPOSTAPI:@"api/Login/PostLogin" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)registerUserWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
//    NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
//    [parameters setObject:userName forKey:@"UserName"];
//    [parameters setObject:pwd forKey:@"Pwd"];
//    [parameters setObject:location?:@"" forKey:@"location"];
//    [parameters setObject:verification forKey:@"verification"];
    [self sendPOSTAPI:@"api/Regist/PostRegistUser" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
//    [self sendPOSTAPI:@"api/Regist/PostRegistUser" withParams:params success:^(NSDictionary *responseDict) {
//        success(responseDict);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
}

- (void)shortMessageParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    
//    [self sendPOSTAPI:@"api/ShortMessage/Post" withParams:params success:^(NSDictionary *responseDict) {
//        success(responseDict);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    [self sendPOSTAPI:@"api/ShortMessage/Post" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)modifyPassWordParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    
//    [self sendPOSTAPI:@"api/UpdatePwd/UpdatePwd" withParams:params success:^(NSDictionary *responseDict) {
//        success(responseDict);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
    [self sendPOSTAPI:@"api/UpdatePwd/UpdatePwd" authorizationType:QMAuthorizationTypeClient withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
