//
//  VPFeedbackViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPFeedbackViewModel.h"
#import "VPAdviceAPI.h"
#import "VPUserManager.h"

@interface VPFeedbackViewModel ()

@property (nonatomic, strong) VPAdviceAPI *adviceAPI;

@end

@implementation VPFeedbackViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.adviceAPI = [[VPAdviceAPI alloc] init];
    }
    return self;
}

- (void)submitAdviceContents:(NSString *)contents success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSString *userID = [VPUserManager sharedInstance].xx_userinfoID;
    [self.adviceAPI submitFeedbackWithUserId:userID.length>0?userID:@""
                                    contents:contents
                                     success:^(NSDictionary *responseDict) {
                                         success();
                                     } failure:^(NSError *error) {
                                         failure(error);
                                     }];
}

@end
