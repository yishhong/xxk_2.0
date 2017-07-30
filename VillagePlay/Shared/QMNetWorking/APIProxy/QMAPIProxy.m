//
//  QMAPIProxy.m
//  QMAPIManage
//
//  Created by Apricot on 16/7/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMAPIProxy.h"
#import "QMAPIManager.h"
#import "NSError+Reason.h"
#import "QMRequestGeneratorWithPOST.h"
#import "QMRequestGeneratorWithGET.h"

@interface QMAPIProxy ()
@property (nonatomic, strong) NSMutableArray *taskIdentifier;
@property (nonatomic, assign) Class requestMethod;
@end

@implementation QMAPIProxy


+ (instancetype)instantiation{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.taskIdentifier = [NSMutableArray array];
    }
    return self;
}

- (Class)HTTPHead{
    return [QMHTTPHead class];
}

- (Class)requestGenerator{
    return self.requestMethod;
}

- (Class)requestConfiguration{
    return [QMRequestConfiguration class];
}


- (void)addTaskIdentifier:(NSUInteger)identifier{
    [self.taskIdentifier addObject:@(identifier)];
}

- (void)cancel{
    [self.taskIdentifier removeAllObjects];
    //执行取消请求
    /*
     ......
     */
}

- (void)PostAPI:(NSString *)api
     withParams:(id)params
        success:(void(^)(NSDictionary *body))success
        failure:(void(^)(NSError *error))failure{
    self.requestMethod = [QMRequestGeneratorWithPOST class];
    NSUInteger identifier = [[QMAPIManager sharedManager] sendAPI:api withParams:params withAPIProxy:self completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",[response.URL absoluteString]);
        if(error){
            //错误
            failure([NSError errorCode:110 message:@"网络异常"]);
            return ;
        }else{
            NSError *error = nil;
            if([response isKindOfClass:[NSHTTPURLResponse class]]){
                NSHTTPURLResponse *HTTPURLResponse = (NSHTTPURLResponse *)response;
                if(HTTPURLResponse.statusCode !=200){
                    error = [NSError errorCode:HTTPURLResponse.statusCode message:@"访问异常"];
                    failure(error);
                    return ;
                }
            }
            if (!data||data==nil) {
                //错误
                error = [NSError errorMessage:@"访问异常"];
                failure(error);
            }else{
                NSDictionary *body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error) {
                    //解析错误
                    failure(error);
                }else{
                    success(body);
                }
            }
        }
    }];
    [self addTaskIdentifier:identifier];
}

- (void)GetAPI:(NSString *)api
     withParams:(id)params
        success:(void(^)(NSDictionary *body))success
        failure:(void(^)(NSError *error))failure{
    self.requestMethod = [QMRequestGeneratorWithGET class];
    NSUInteger identifier = [[QMAPIManager sharedManager] sendAPI:api withParams:params withAPIProxy:self completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",[response.URL absoluteString]);
        if(error){
            //错误
            failure(error);
            return ;
        }else{
            NSError *error = nil;
            if([response isKindOfClass:[NSHTTPURLResponse class]]){
                NSHTTPURLResponse *HTTPURLResponse = (NSHTTPURLResponse *)response;
                if(HTTPURLResponse.statusCode !=200){
                    error = [NSError errorCode:1024 message:@"网络异常"];
                    failure(error);
                    return ;
                }
            }
            if (!data||data==nil) {
                //错误
                error = [NSError errorMessage:@"访问异常"];
                failure(error);
            }else{
                NSDictionary *body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error) {
                    //解析错误
                    failure(error);
                }else{
                    success(body);
                }
            }
        }
    }];
    [self addTaskIdentifier:identifier];
}

- (void)uploadFileWithAPI:(NSString *)api withData:(NSData *)imageData success:(void(^)(NSDictionary *body))success failure:(void(^)(NSError *error))failure{
    self.requestMethod = [QMRequestGeneratorWithPOST class];
    NSUInteger identifier = [[QMAPIManager sharedManager] uploadAPI:api withData:imageData withAPIProxy:self completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",[response.URL absoluteString]);
        if(error){
            //错误
            failure(error);
        }else{
            NSError *error = nil;
            if (!data||data==nil) {
                //错误
                error = [NSError errorMessage:@"访问异常"];
                failure(error);
            }else{
                NSDictionary *body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error) {
                    //解析错误
                    failure(error);
                }else{
                    success(body);
                }
            }
        }
    }];
    [self addTaskIdentifier:identifier];
}

@end
