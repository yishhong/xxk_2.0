//
//  VPTopicAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicAPI.h"

@implementation VPTopicAPI

-(void)topicListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Project/GetTopicList" withParams:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

@end
