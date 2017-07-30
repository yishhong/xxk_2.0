//
//  HBAuthorizationAPI.m
//  HotelBusiness
//
//  Created by Apricot on 16/9/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAuthorizationAPI.h"
#import "VPAPIConfiguration.h"
#import "VPAuthorizationHTTPHead.h"
#import "VPUserManager.h"

@implementation VPAuthorizationAPI
- (Class)requestConfiguration{
    return [VPAPIConfiguration class];
}
- (Class)HTTPHead{
    return [VPAuthorizationHTTPHead class];
}
- (void)authorizationClientTokenSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    //需要判断是否 有效期
    //获取当前的时间
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    //获取本地的数据
    NSDictionary *authorizationInfo = [[VPUserManager sharedInstance] loadAuthorizationToken];
    //判断当前时间是否过期
    if(authorizationInfo&&(endTime<[authorizationInfo[@"ValidityTime"] doubleValue])){
        if(authorizationInfo[@"AuthorizationType"]){
//            if([authorizationInfo[@"AuthorizationType"] isEqualToString:@"client_credentials"]){
//
//            }
            success();
            return;
        }
    }
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    parameters[@"grant_type"] = @"client_credentials";

    [self PostAPI:@"Token" withParams:parameters success:^(NSDictionary *body) {
        //存储token
        CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
        NSMutableDictionary *tokenDict = [NSMutableDictionary dictionaryWithDictionary:body];
        [tokenDict setObject:[NSNumber numberWithDouble:begin+[tokenDict[@"expires_in"] doubleValue]] forKey:@"ValidityTime"];
        [tokenDict setObject:@"client_credentials" forKey:@"AuthorizationType"];
        //储存获取的token
        [[VPUserManager sharedInstance] saveAuthorizationToken:tokenDict];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)authorizationPasswordTokenSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    //需要判断是否 有效期
    //获取当前的时间
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    //获取本地的数据
    NSDictionary *authorizationInfo = [[VPUserManager sharedInstance] loadAuthorizationToken];
    //判断当前时间是否过期
    if(authorizationInfo&&(endTime<[authorizationInfo[@"ValidityTime"] doubleValue])){
        if(authorizationInfo[@"AuthorizationType"]){
            if([authorizationInfo[@"AuthorizationType"] isEqualToString:@"password"]){
                success();
                return;
            }
        }
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"grant_type"] = @"password";
    NSDictionary * loginInfo = [[VPUserManager sharedInstance] xx_loginInfo];

    parameters[@"username"] = loginInfo[@"userName"];
    parameters[@"password"] = loginInfo[@"pwd"];
    
    [self PostAPI:@"Token" withParams:parameters success:^(NSDictionary *body) {
        //存储token
        CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
        NSMutableDictionary *tokenDict = [NSMutableDictionary dictionaryWithDictionary:body];
        [tokenDict setObject:[NSNumber numberWithDouble:begin+[tokenDict[@"expires_in"] doubleValue]] forKey:@"ValidityTime"];
        [tokenDict setObject:@"password" forKey:@"AuthorizationType"];

        //储存获取的token
        [[VPUserManager sharedInstance] saveAuthorizationToken:tokenDict];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
