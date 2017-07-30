//
//  VPLoginViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLoginViewModel.h"
#import "VPLoginAPI.h"
#import "VPUserManager.h"
#import "VPUserInfoModel.h"
#import "YYModel.h"
#import "NSError+Reason.h"

@interface VPLoginViewModel ()

@property(strong, nonatomic)VPLoginAPI *loginApi;

@end

@implementation VPLoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.loginApi =[[VPLoginAPI alloc]init];
    }
    return self;
}

- (void)loginUserName:(NSString *)userName pwd:(NSString *)pwd location:(NSString *)location success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSError *error = nil;
    if ([userName isKindOfClass:[NSNull class]]||userName.length==0) {
        error = [NSError errorMessage:@"用户名不能为空！"];
    }else if ([pwd isKindOfClass:[NSNull class]]||pwd.length==0){
        error = [NSError errorMessage:@"密码不能为空！"];
    }
    if(error){
        failure(error);
        return;
    }
    NSDictionary *LoginParams=@{@"UserName":userName,
                                @"Pwd":pwd,
                                @"location":location};
    
    [self.loginApi loginAccountWithParams:LoginParams success:^(NSDictionary *responseDict) {
        
        VPUserInfoModel * userInfoModel = [VPUserInfoModel yy_modelWithJSON:responseDict[@"body"]];
        //保存用户信息
        [[VPUserManager sharedInstance] xx_saveUserInfo:userInfoModel];
        //保存登录用户的账号信息
        [[VPUserManager sharedInstance] xx_saveLoginInfoWithUserName:userInfoModel.username pwd:pwd];

        success();
    } failure:^(NSError *error) {
        //登录失败删除保存的登录信息
        [[VPUserManager sharedInstance] xx_deleteLoginInfo];
        failure(error);
    }];
}

- (void)wechatLoginWithParams:(UMSocialUserInfoResponse *)userInfoResponse success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSString *openId = userInfoResponse.originalResponse[@"openid"];
    NSString *unionId = userInfoResponse.originalResponse[@"unionid"];
    
    NSDictionary *params=@{@"openid":openId,
                           @"unionid":unionId};
    
    [self.loginApi loginOthertWithParams:params success:^(NSDictionary *responseDict) {
        VPUserInfoModel * userInfoModel = [VPUserInfoModel yy_modelWithJSON:responseDict[@"body"]];
        [[VPUserManager sharedInstance] xx_saveUserInfo:userInfoModel];
        //保存登录用户的账号信息
        [[VPUserManager sharedInstance] xx_saveLoginInfoWithUserName:userInfoModel.username pwd:@"123456"];
        success();
    } failure:^(NSError *error) {
        if(error.code == 400){
            NSInteger sex = [userInfoResponse.originalResponse[@"sex"] integerValue];
            /*
             registWechatUserWithUserName:userInfoResponse.originalResponse[@"openid"]
             nickName:userInfoResponse.name
             unionid:userInfoResponse.originalResponse[@"unionid"]
             sex:[userInfoResponse.originalResponse[@"sex"] longValue]
             photoUrl:userInfoResponse.iconurl
             province:userInfoResponse.originalResponse[@"province"]
             city:userInfoResponse.originalResponse[@"city"]
             */
            NSMutableDictionary *registUserInfoDict = [NSMutableDictionary dictionary];
            registUserInfoDict[@"userName"] = userInfoResponse.originalResponse[@"openid"];
            registUserInfoDict[@"pwd"] = @"123456";//第三方登录的密码为默认的
            registUserInfoDict[@"unionid"] = userInfoResponse.originalResponse[@"unionid"];
            registUserInfoDict[@"sex"] = sex==0?@"未知":(sex==1?@"男":@"女");
            registUserInfoDict[@"provinceID"] = userInfoResponse.originalResponse[@"province"];
            registUserInfoDict[@"cityID"] = userInfoResponse.originalResponse[@"city"];
            registUserInfoDict[@"photoUrl"] = userInfoResponse.iconurl;
            registUserInfoDict[@"nickname"] = userInfoResponse.name;
            registUserInfoDict[@"kfopenid"] = userInfoResponse.originalResponse[@"openid"];
            [self.loginApi registerUserWithParams:registUserInfoDict success:^(NSDictionary *responseDict) {
                VPUserInfoModel * userInfoModel =[VPUserInfoModel yy_modelWithJSON:responseDict[@"body"]];
                [[VPUserManager sharedInstance] xx_saveUserInfo:userInfoModel];
                //保存登录用户的账号信息
                [[VPUserManager sharedInstance] xx_saveLoginInfoWithUserName:userInfoModel.username pwd:@"123456"];
                success();
            } failure:^(NSError *error) {
                //注册失败删除保存的登录信息
                [[VPUserManager sharedInstance] xx_deleteLoginInfo];
                failure(error);
            }];
        }else{
            //登录失败删除保存的登录信息
            [[VPUserManager sharedInstance] xx_deleteLoginInfo];
            failure(error);
        }
    }];
    
    
}


-(void)registUserPhoneNum:(NSString *)phoneNum location:(NSString *)location verification:(NSString *)verification pwd:(NSString *)pwd success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSError *error = nil;
    if ([phoneNum isKindOfClass:[NSNull class]]||phoneNum.length==0){
        error = [NSError errorMessage:@"手机号码不能为空！"];
    }else if ([verification isKindOfClass:[NSNull class]]||verification.length==0){
        error = [NSError errorMessage:@"验证码不能为空！"];
    }else if ([pwd isKindOfClass:[NSNull class]]||pwd.length==0){
        error = [NSError errorMessage:@"密码不能为空！"];
    }
    if(error){
        failure(error);
        return;
    }
    NSDictionary *params =@{@"userName":phoneNum,
                            @"PhoneNum":phoneNum,
                            @"verification":verification,
                            @"pwd":pwd,
                            @"nickname":[NSString stringWithFormat:@"xxk_%@",[phoneNum substringWithRange:NSMakeRange(phoneNum.length-4, 4)]],
//                            @"location":location
                            };
//    [[VPUserManager sharedInstance] xx_saveLoginInfoWithUserName:phoneNum pwd:pwd];
    [self.loginApi registerUserWithParams:params success:^(NSDictionary *responseDict) {
        VPUserInfoModel * userInfoModel = [VPUserInfoModel yy_modelWithJSON:responseDict[@"body"]];
        [[VPUserManager sharedInstance] xx_saveUserInfo:userInfoModel];
        [[VPUserManager sharedInstance] xx_saveLoginInfoWithUserName:userInfoModel.username pwd:pwd];

        success();
    } failure:^(NSError *error) {
        [[VPUserManager sharedInstance] xx_deleteLoginInfo];
        failure(error);
    }];
}

- (void)registWechatUserWithUserName:(NSString *)userName nickName:(NSString *)nickName unionid:(NSString *)unionid sex:(NSInteger)sex photoUrl:(NSString *)photoUrl province:(NSString *)province city:(NSString *)city success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *registUserInfoDict = [NSMutableDictionary dictionary];
    registUserInfoDict[@"userName"] = userName;
    registUserInfoDict[@"pwd"] = @"123456";//第三方登录的密码为默认的
    registUserInfoDict[@"unionid"] = unionid;
    registUserInfoDict[@"sex"] = sex==0?@"未知":(sex==1?@"男":@"女");
    
    registUserInfoDict[@"provinceID"] = province;
    registUserInfoDict[@"cityID"] = city;
    registUserInfoDict[@"photoUrl"] = photoUrl;
    registUserInfoDict[@"nickname"] = nickName;
    [self.loginApi registerUserWithParams:registUserInfoDict success:^(NSDictionary *responseDict) {
        VPUserInfoModel * userInfoModel =[VPUserInfoModel yy_modelWithJSON:responseDict[@"body"]];
        [[VPUserManager sharedInstance] xx_saveUserInfo:userInfoModel];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)postShortMessage:(NSString *)phoneNum type:(VPShortMessageType)type success:(void (^)())success failure:(void (^)(NSError *))failure{

    if ([phoneNum isKindOfClass:[NSNull class]]||phoneNum.length==0) {
        NSError *error = [NSError errorMessage:@"手机号码不能为空！"];
        failure(error);
        return;
    }
    NSString *messageType;
    switch (type) {
        case VPShortMessageType_Register:
        {
            messageType=@"1";
            break;}
        case VPShortMessageType_ModifyPassWord:
        {
            messageType=@"2";
            break;}
        default:
            break;
    }

    NSDictionary *params =@{@"phoneNum":phoneNum,
                            @"type":messageType};
    [self.loginApi shortMessageParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)modifyPassWord:(NSString *)phoneNum pwd:(NSString *)pwd rePwd:(NSString *)rePwd verification:(NSString *)verification  success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params=@{@"phoneNum":phoneNum,
                           @"pwd":pwd,
                           @"rePwd":rePwd,
                           @"verification":verification};
    [self.loginApi modifyPassWordParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
