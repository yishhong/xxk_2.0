//
//  QMAPIManager.m
//  QMAPIManage
//
//  Created by Apricot on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMAPIManager.h"
#import "QMIntegrateCenter.h"
#import "NSURLSession+Session.h"

@interface QMAPIManager ()
/**
 *  存储所有的请求
 */
@property (nonatomic, strong) NSMutableDictionary *taskDict;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation QMAPIManager


+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static id _shared;
    dispatch_once(&onceToken, ^{
        _shared = [[[self class] alloc] init];
    });
    return _shared;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.taskDict = [NSMutableDictionary dictionary];
        self.session = [NSURLSession sharedSession];
    }
    return self;
}

- (NSUInteger)sendAPI:(NSString *)api withParams:(id)params withAPIProxy:(QMAPIProxy *)apiProxy completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    //配置请求的环境
    [QMIntegrateCenter sharedManager].httpHead = [apiProxy HTTPHead];
    [QMIntegrateCenter sharedManager].requestGenerator = [apiProxy requestGenerator];
    [QMIntegrateCenter sharedManager].requestConfiguration = [apiProxy requestConfiguration];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithApi:api withParams:params completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@-->>",response.URL.absoluteString);
        NSLog(@"error:%@",error.description);
        if(data.length>0){
            NSError *error;
            NSDictionary* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if(error){
                NSLog(@"error:%@",error.description);
            }else{
                NSLog(@"data:%@",responseData.description);
            }
        }else{
            NSLog(@"data为空");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data,response,error);
        });
    }];
    [task resume];
    [self.taskDict setObject:task forKey:@(task.taskIdentifier)];
    return task.taskIdentifier;
}

- (NSUInteger)uploadAPI:(NSString *)api withData:(NSData *)data withAPIProxy:(QMAPIProxy *)apiProxy completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler{
    //配置请求的环境
    [QMIntegrateCenter sharedManager].httpHead = [apiProxy HTTPHead];
    [QMIntegrateCenter sharedManager].requestGenerator = [apiProxy requestGenerator];
    [QMIntegrateCenter sharedManager].requestConfiguration = [apiProxy requestConfiguration];
    NSURLSessionUploadTask *task = [self.session uploadDataWithApi:api withData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data,response,error);
        });
    }];
    [task resume];
    return task.taskIdentifier;
}
@end
