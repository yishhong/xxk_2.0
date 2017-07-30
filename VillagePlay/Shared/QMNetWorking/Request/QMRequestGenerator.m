//
//  QMRequestGenerator.m
//  QMAPIManage
//
//  Created by Apricot on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMRequestGenerator.h"
#import "QMRequestGeneratorWithGET.h"

@interface QMRequestGenerator ()
//@property (nonatomic, strong) NSMutableURLRequest *request;
@end

@implementation QMRequestGenerator

+ (instancetype)instantiation{
    return [[QMRequestGeneratorWithGET alloc] init];
}

- (NSURLRequest *)requestWithAPI:(NSString *)api withParams:(id)params{
  //通过一个配置的文件拿到URL 以及请求的方式
    NSURL *url = [NSURL URLWithString:[self urlWithApi:api]];
    NSParameterAssert(url);
    if(!url){
        return nil;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:[self timeoutInterval]];
    NSParameterAssert(request);
    if(!request){
        return nil;
    }
    request.HTTPMethod = [self HTTPMethod];
    request = [[self HTTPHeadsWithRequest:request] mutableCopy];
    
    request = [[self HTTPBodyWithRequest:request
                              withParams:params] mutableCopy];
    
    return request;
}

- (NSString *)urlWithApi:(NSString *)api{
    QMRequestConfiguration *requestConfiguration = [[QMIntegrateCenter sharedManager].requestConfiguration instantiation];
//    [requestConfiguration.serverURL stringByAppendingString:api
    return [NSString stringWithFormat:@"%@%@",requestConfiguration.serverURL,api];
}

- (NSString *)HTTPMethod{
    return @"GET";
}

- (NSURLRequest *)HTTPHeadsWithRequest:(NSURLRequest *)request{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];

    QMHTTPHead *httpHead = [[QMIntegrateCenter sharedManager].httpHead instantiation];
    if(httpHead.httpHead){
        for (NSString *key in httpHead.httpHead) {
            [mutableRequest setValue:httpHead.httpHead[key] forHTTPHeaderField:key];
        }
    }
    return mutableRequest;
}

- (NSURLRequest *)HTTPBodyWithRequest:(NSURLRequest *)request withParams:(id)params{
    return request;
}

- (NSTimeInterval)timeoutInterval{
    QMRequestConfiguration *requestConfiguration = [[QMIntegrateCenter sharedManager].requestConfiguration instantiation];
    return requestConfiguration.netWokingTimeoutSeconds;
}

@end
