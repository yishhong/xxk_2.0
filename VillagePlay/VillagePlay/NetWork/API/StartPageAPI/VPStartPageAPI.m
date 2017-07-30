//
//  VPStartPageAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/17.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPStartPageAPI.h"

@implementation VPStartPageAPI

- (void)loadStartPageAPISuccess:(Success)success failure:(Failure)failure{
    [self sendGETAPI:@"api/Main/GetStartPage" authorizationType:QMAuthorizationTypeClient params:nil success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
