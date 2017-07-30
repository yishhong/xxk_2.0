//
//  VPUserManager.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserManager.h"
#import "VPUserInfoModel.h"
#import "VPStorageManager.h"
#import "JPUSHService.h"
//#import "SDImageCache.h"
#import <SDWebImageDownloader.h>
#import <SDImageCache.h>
#import "AppKeFuLib.h"

@interface VPUserManager ()
/**
 *  授权Token
 */
@property (nonatomic, strong) NSDictionary * authorizationInfo;
/**
 *  用户Model
 */
@property (nonatomic, strong) VPUserInfoModel *userInfoModel;

/**
 获取通知
 */
@property (nonatomic, assign) BOOL isNotice;

@end

@implementation VPUserManager


+(instancetype)sharedInstance{
    
    static id sharedInstance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance =[[self alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfoModel = [VPStorageManager loadUserInfo];
        if(self.userInfoModel){
            [self xx_saveUserInfo:self.userInfoModel];
        }
    }
    return self;
}

- (void)xx_saveLoginInfo:(NSDictionary *)loginInfo{
    [VPStorageManager saveLoginInfo:loginInfo];
}

- (void)xx_saveLoginInfoWithUserName:(NSString *)userName pwd:(NSString *)pwd{
    NSMutableDictionary *loginInfo = [NSMutableDictionary dictionary];
    loginInfo[@"userName"] = userName;
    loginInfo[@"pwd"] = pwd;

    [VPStorageManager saveLoginInfo:loginInfo];
}

- (NSDictionary *)xx_loginInfo{
    return [VPStorageManager loadLoginInfo];
}

- (void)xx_deleteLoginInfo{
    [VPStorageManager deleteLoginInfo];
}


- (void)xx_saveUserInfo:(VPUserInfoModel *)userInfo{
    
    self.userInfoModel = userInfo;
    [VPStorageManager saveUserInfo:self.userInfoModel];
    //判断是否接收通知 注册极光
    if(self.userInfoModel.isNotice){
        [JPUSHService setTags:nil alias:self.userInfoModel.vid fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        }];
    }else{
        [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        }];
    }
    [self downloaderImageWithURL:userInfo.smallHeadPhoto];
}

/**
 下载头像

 @param imageUrlStr 图片的URL
 */
- (void)downloaderImageWithURL:(NSString *)imageUrlStr{
    //下载头像
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:imageUrlStr]){
        return;
    }
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 下载进度block
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        // 下载完成block
        [[SDImageCache sharedImageCache] storeImage:image forKey:imageUrlStr];
    }];
}

- (VPUserInfoModel *)xx_userInfo{
    return self.userInfoModel;
}

- (void)xx_deleteUserInfo{
    //删除用户
    self.userInfoModel =nil;
    //清理登录的账号信息
    [VPStorageManager deleteLoginInfo];
    //清理用户的详情信息
    [VPStorageManager deleteUserInfo];
    //清理授权数据
    [self deleteAuthorizationToken];
    [[AppKeFuLib sharedInstance] clearAllFileCache];
}

- (void)xx_updateUserInfo:(VPUserInfoModel *)userInfo{
    
    self.userInfoModel =(VPUserInfoModel *)userInfo;
    [VPStorageManager saveUserInfo:self.userInfoModel];
    //下载头像
    [self downloaderImageWithURL:userInfo.smallHeadPhoto];
}

-(NSString *)xx_userinfoID{

    return self.userInfoModel.vid.length>0?self.userInfoModel.vid:@"";
}

- (void)saveAuthorizationToken:(NSDictionary *)authorization{
    self.authorizationInfo = authorization;
    [VPStorageManager saveAuthorization:authorization];
}

- (NSDictionary *)loadAuthorizationToken{
    return self.authorizationInfo;
}

- (void)deleteAuthorizationToken{
    self.authorizationInfo = nil;
    //删除用户Token
    [VPStorageManager deleteAuthorization];
    //清理极光
    [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
    }];
}

@end
