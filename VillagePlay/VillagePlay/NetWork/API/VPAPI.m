//
//  VPAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAPI.h"

#import "VPAPIConfiguration.h"
#import "QMRequestGeneratorWithPOST.h"
#import "NSError+Reason.h"
#import "AFHTTPSessionManager.h"
#import "VPHTTPHead.h"
#import "VPAuthorizationAPI.h"


@interface VPAPI ()
@property (nonatomic, strong)VPAuthorizationAPI *authorizationAPI;

@end

@implementation VPAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.authorizationAPI = [[VPAuthorizationAPI alloc] init];
    }
    return self;
}
- (Class)requestConfiguration{
    return [VPAPIConfiguration class];
}

- (Class)HTTPHead{
    return [VPHTTPHead class];
}


//client_credentials
-(void)sendPOSTAPI:(NSString *)api withParams:(id)params success:(Success)success failure:(Failure)failure{
    //判断授权
    [self.authorizationAPI authorizationClientTokenSuccess:^{
        //请求接口
        [self PostAPI:api withParams:params success:^(NSDictionary *body) {
            if ([body[@"state"] integerValue] == 200) {
                success(body);
            }else{
                NSError *error = [NSError errorCode:[body[@"state"] integerValue] message:body[@"message"]];
                failure(error);
            }
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)sendGETAPI:(NSString *)api withParams:(id)params success:(Success)success failure:(Failure)failure{
    [self.authorizationAPI authorizationClientTokenSuccess:^{
        [self GetAPI:api withParams:params success:^(NSDictionary *body) {
            if ([body[@"state"] integerValue] == 200) {
                //判断授权
                success(body);
            }else{
                NSError *error = [NSError errorCode:[body[@"state"] integerValue] message:body[@"message"]];
                failure(error);
            }
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

- (void)sendPOSTAPI:(NSString *)api authorizationType:(QMAuthorizationType)authorizationType withParams:(id)params success:(Success)success failure:(Failure)failure{
    switch (authorizationType) {
        case QMAuthorizationTypeClient:{
            [self.authorizationAPI authorizationClientTokenSuccess:^{
                //请求接口
                [self PostAPI:api withParams:params success:^(NSDictionary *body) {
                    if ([body[@"state"] integerValue] == 200) {
                        success(body);
                    }else{
                        NSError *error = [NSError errorCode:[body[@"state"] integerValue] message:body[@"message"]];
                        failure(error);
                    }
                } failure:^(NSError *error) {
                    failure(error);
                }];
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        case QMAuthorizationTypePassword:{
            [self.authorizationAPI authorizationPasswordTokenSuccess:^{
                //请求接口
                [self PostAPI:api withParams:params success:^(NSDictionary *body) {
                    if ([body[@"state"] integerValue] == 200) {
                        success(body);
                    }else{
                        NSError *error = [NSError errorCode:[body[@"state"] integerValue] message:body[@"message"]];
                        failure(error);
                    }
                } failure:^(NSError *error) {
                    failure(error);
                }];
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        default:
            break;
    }
}


- (void)sendGETAPI:(NSString *)api authorizationType:(QMAuthorizationType)authorizationType params:(id)params success:(Success)success failure:(Failure)failure{
    switch (authorizationType) {
        case QMAuthorizationTypeClient:{
            [self.authorizationAPI authorizationClientTokenSuccess:^{
                [self GetAPI:api withParams:params success:^(NSDictionary *body) {
                    if ([body[@"state"] integerValue] == 200) {
                        //判断授权
                        success(body);
                    }else{
                        NSError *error = [NSError errorCode:[body[@"state"] integerValue] message:body[@"message"]];
                        failure(error);
                    }
                } failure:^(NSError *error) {
                    failure(error);
                }];
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        case QMAuthorizationTypePassword:{
            [self.authorizationAPI authorizationPasswordTokenSuccess:^{
                [self GetAPI:api withParams:params success:^(NSDictionary *body) {
                    if ([body[@"state"] integerValue] == 200) {
                        //判断授权
                        success(body);
                    }else{
                        NSError *error = [NSError errorCode:[body[@"state"] integerValue] message:body[@"message"]];
                        failure(error);
                    }
                } failure:^(NSError *error) {
                    failure(error);
                }];
            } failure:^(NSError *error) {
                failure(error);
            }];
        }break;
        default:
            break;
    }

}


#warning 暂时废弃
//上传图片
- (void)uploadAPI:(NSString *)api withData:(NSArray *)datas success:(Success)success failure:(Failure)failure{
    
    [self.authorizationAPI authorizationClientTokenSuccess:^{
        //改用AFN 上传图片
        QMRequestConfiguration * configuration = [[[self requestConfiguration] alloc] init];
        AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:configuration.serverURL]];
        [session POST:api parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            int i =0;
            for (NSData *data in datas) {
                [formData appendPartWithFileData :data name:@"fileData" fileName:[NSString stringWithFormat:@"%dimage.jpg",i] mimeType:@"image/jpeg"];
                i++;
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%lld",uploadProgress.completedUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"state"] integerValue] == 200) {
                success(responseObject);
            }else{
                NSError *error = [NSError errorCode:[responseObject[@"state"] integerValue] message:responseObject[@"message"]];
                failure(error);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
