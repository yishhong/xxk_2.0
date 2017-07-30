
//  NSURLSession+Session.m
//  QMAPIManage
//
//  Created by Apricot on 16/7/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "NSURLSession+Session.h"
#import "QMRequestGenerator.h"
#import "QMIntegrateCenter.h"
static NSURLSession *session = nil;
static NSURLSessionConfiguration *configuration = nil;

@implementation NSURLSession (Session)
- (NSURLSessionDataTask *)dataTaskWithApi:(NSString *)api withParams:(id)params completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler{
    if(!session){
        if(!configuration){
            configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        session = [NSURLSession sessionWithConfiguration:configuration];
    }
    NSURLRequest *request = nil;
    QMRequestGenerator *requestGenerator = [[QMIntegrateCenter sharedManager].requestGenerator instantiation];
    request = [requestGenerator requestWithAPI:api withParams:params];
    NSLog(@"API:%@ RequestBody:%@",request.URL.absoluteString,[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data,response,error);
    }];
    return task;
}

- (NSURLSessionUploadTask *)uploadDataWithApi:(NSString *)api withData:(NSData *)data completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler{
    if(!session){
        if(!configuration){
            configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        session = [NSURLSession sessionWithConfiguration:configuration];
    }
    NSURLRequest *request = nil;
    QMRequestGenerator *requestGenerator = [[QMIntegrateCenter sharedManager].requestGenerator instantiation];
    request = [requestGenerator requestWithAPI:api withParams:nil];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data,response,error);
    }];
    return task;
}

@end
