//
//  VPPlayAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayAPI.h"

@implementation VPPlayAPI

-(void)playListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/FinePlay/List" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)playDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/FinePlay/Detail" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
