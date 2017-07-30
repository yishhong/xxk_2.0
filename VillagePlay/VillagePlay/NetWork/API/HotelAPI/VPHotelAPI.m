//
//  VPHotelAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelAPI.h"

@implementation VPHotelAPI

- (void)hotelListParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure{

    [self sendGETAPI:@"api/Homestay/Getprivate_hotel_info" authorizationType:QMAuthorizationTypeClient params:params success:^(NSDictionary *responseDict) {
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
