//
//  VPBannerAPI.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBannerAPI.h"

@implementation VPBannerAPI

- (void)loadCityBannerWithCityID:(NSInteger)cityID success:(Success)success failure:(Failure)failure{
    NSDictionary *params = @{@"cityId":@(cityID)};
    [self sendGETAPI:@"api/Banner/GetDT_Advertisement" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
