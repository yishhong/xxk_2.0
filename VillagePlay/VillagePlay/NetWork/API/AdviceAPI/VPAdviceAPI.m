//
//  VPAdviceAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAdviceAPI.h"

@implementation VPAdviceAPI

- (void)submitFeedbackWithUserId:(NSString *)userId contents:(NSString *)contents success:(Success)success failure:(Failure)failure{
    NSDictionary *params = @{
                             @"userId":userId,
                             @"contents":contents
                             };
    [self sendPOSTAPI:@"api/Advice/Add" authorizationType:QMAuthorizationTypePassword withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
