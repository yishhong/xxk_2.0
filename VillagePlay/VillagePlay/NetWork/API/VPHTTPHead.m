//
//  VPHTTPHead.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHTTPHead.h"
#import "VPUserManager.h"

@implementation VPHTTPHead
- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置授权的token
        NSDictionary *authorizationInfo = [[VPUserManager sharedInstance] loadAuthorizationToken];
        if([[authorizationInfo allKeys] containsObject:@"access_token"]&&[[authorizationInfo allKeys] containsObject:@"token_type"]){
            self.httpHead[@"Authorization"] = [NSString stringWithFormat:@"%@ %@",authorizationInfo[@"token_type"],authorizationInfo[@"access_token"]];
        }
    }
    return self;
}
@end
