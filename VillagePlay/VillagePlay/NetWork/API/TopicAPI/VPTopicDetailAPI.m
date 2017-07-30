//
//  VPTopicDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicDetailAPI.h"

@implementation VPTopicDetailAPI

-(void)topicDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Project/GetTopicModel" authorizationType:QMAuthorizationTypePassword params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

@end
