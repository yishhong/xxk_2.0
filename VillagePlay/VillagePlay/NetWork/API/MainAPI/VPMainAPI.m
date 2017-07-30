//
//  VPMainAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMainAPI.h"

@implementation VPMainAPI

- (void)loadMainListWithParams:(NSDictionary *)parmas success:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Main/GetMainVData" authorizationType:QMAuthorizationTypeClient params:parmas success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
