//
//  VPLiveDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveDetailAPI.h"

@implementation VPLiveDetailAPI

- (void)liveDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    [self sendGETAPI:@"api/XiaXKLive/GetXiaXKLiveDetailList" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
