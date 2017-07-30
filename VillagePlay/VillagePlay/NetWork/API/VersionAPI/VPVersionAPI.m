//
//  VPVersionAPI.m
//  VillagePlay
//
//  Created by Apricot on 2017/1/14.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "VPVersionAPI.h"
#import "InfoPlist.h"

@implementation VPVersionAPI

- (void)loadVersionAPISuccess:(Success)success failure:(Failure)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"editionNum"] = [InfoPlist buildVersion];//这个版本号必须的全是数字 （注：这里版本号取得是Build 非Version,发布如果被拒了需要后台配合修改版本号）
    params[@"type"] = @"2";//type:（1 安卓 2 ios）
    [self sendGETAPI:@"api/Edition/GetEditionModel" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
