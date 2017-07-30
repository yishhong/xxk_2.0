//
//  VPLoginManager.m
//  VillagePlay
//
//  Created by Apricot on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLoginManager.h"
#import "VPLoginAPI.h"
#import <UMSocialCore/UMSocialCore.h>


@interface VPLoginManager ()

@property (nonatomic ,strong) VPLoginAPI * loginApi;

@end



@implementation VPLoginManager


+ (instancetype)instantiation{
    return [[VPLoginManager alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loginApi = [[VPLoginAPI alloc] init];
    }
    return self;
}

- (void)loginWithType:(VPLoginType)loginType params:(NSDictionary *)params{
    switch (loginType) {
        case VPLoginTypeAccount:{
            [self.loginApi loginAccountWithParams:params success:^(NSDictionary *responseDict) {
                
            } failure:^(NSError *error) {
                
            }];
        }break;
        case VPLoginTypeWechat:{
            [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
                [self registerUserWith:result];
            }];
        }break;
        case VPLoginTypeSina:{
            [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
                [self registerUserWith:result];
            }];
        }break;
        case VPLoginTypeQQ:{
            [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
                [self registerUserWith:result];
            }];
        }break;
        default:
            break;
    }
}

- (void)registerUserWith:(NSDictionary *)params{
    [self.loginApi loginOthertWithParams:params success:^(NSDictionary *responseDict) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
