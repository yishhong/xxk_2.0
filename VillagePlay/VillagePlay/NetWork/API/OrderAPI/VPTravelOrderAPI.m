//
//  VPTravelOrderAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderAPI.h"

@implementation VPTravelOrderAPI

- (void)travelOrderParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    [self sendGETAPI:@"api/MyOrder/GetMyOrderVList" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
