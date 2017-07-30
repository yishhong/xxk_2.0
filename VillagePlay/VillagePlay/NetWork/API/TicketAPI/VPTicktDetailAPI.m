//
//  VPTicktDetailAPI.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicktDetailAPI.h"

@implementation VPTicktDetailAPI

- (void)ticketDetailParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Ticket/GetTicket" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
