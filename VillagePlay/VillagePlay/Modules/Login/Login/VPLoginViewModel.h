//
//  VPLoginViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPUserInfoModel.h"
#import <UMSocialCore/UMSocialCore.h>

//短信类型
typedef enum{
    VPShortMessageType_Register=1,      //注册
    VPShortMessageType_ModifyPassWord=2, //修改密码
}VPShortMessageType;


@interface VPLoginViewModel : NSObject

/**
 *  登录
 *
 *  @param UserName 用户名
 *  @param Pwd      用户密码
 *  @param location 定位
 */
- (void)loginUserName:(NSString *)userName pwd:(NSString *)pwd location:(NSString *)location success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 微信登录以及注册

 @param params 友盟的登录信息
 @param success 成功回调
 @param failure 失败回调
 */
- (void)wechatLoginWithParams:(UMSocialUserInfoResponse *)params success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  注册用户
 *
 *  @param userName 用户名
 *  @param pwd      密码
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)registUserPhoneNum:(NSString *)phoneNum location:(NSString *)location verification:(NSString *)verification pwd:(NSString *)pwd success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 微信用户注册 暂时失效 使用wechatLoginWithParams接口

 @param userName 用户登录的账号(微信openid)
 @param nickName 昵称
 @param unionid 微信的unionid(多平台)
 @param sex 性别（微信的sex 0未知,1男,2女）
 @param photoUrl 头像
 @param province 省
 @param city 市
 @param success 成功回调
 @param failure 失败回调
 */
- (void)registWechatUserWithUserName:(NSString *)userName nickName:(NSString *)nickName unionid:(NSString *)unionid sex:(NSInteger)sex photoUrl:(NSString *)photoUrl province:(NSString *)province city:(NSString *)city success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  发送短信验证码
 *
 *  @param phoneNum 手机号码
 *  @param type     短信类型  VPShortMessageType_Register=注册 VPShortMessageType_ModifyPassWord=修改密码
 *  @param success  success block
 *  @param failure  failure block
 */
-(void)postShortMessage:(NSString *)phoneNum type:(VPShortMessageType)type success:(void(^)())success failure:(void(^)(NSError * error))failure;


/**
 *  修改密码
 *
 *  @param phoneNum     手机号码
 *  @param pwd          密码
 *  @param rePwd        重复密码
 *  @param verification 验证码
 *  @param success  success block
 *  @param failure  failure block
 */
-(void)modifyPassWord:(NSString *)phoneNum pwd:(NSString *)pwd rePwd:(NSString *)rePwd verification:(NSString *)verification  success:(void(^)())success failure:(void(^)(NSError * error))failure;

@end
