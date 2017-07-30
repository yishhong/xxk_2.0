//
//  VPAPI.h
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMAPIProxy.h"

typedef enum : NSUInteger {
    QMAuthorizationTypeClient  =   0,//客户端授权模式(未登录)
    QMAuthorizationTypePassword     ,//密码授权模式（已登录）
} QMAuthorizationType;

#define Authorization

typedef void(^Success)(NSDictionary *responseDict);
typedef void(^Failure)(NSError *error);

@interface VPAPI : QMAPIProxy

/**
 POST请求(项目)

 @param api 接口名
 @param params 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)sendPOSTAPI:(NSString *)api withParams:(id)params success:(Success)success failure:(Failure)failure;

/**
 GET请求(项目)

 @param api 接口名
 @param params 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)sendGETAPI:(NSString *)api withParams:(id)params success:(Success)success failure:(Failure)failure;

/**
 *  POST请求(项目)
 *
 *  @param api               接口名
 *  @param authorizationType 授权方式
 *  @param params            接口参数
 *  @param success           成功回调
 *  @param failure           失败回调
 */
-(void)sendPOSTAPI:(NSString *)api authorizationType:(QMAuthorizationType)authorizationType withParams:(id)params success:(Success)success failure:(Failure)failure;

/**
 *  GET请求(项目)
 *
 *  @param api               接口名
 *  @param authorizationType 授权方式
 *  @param params            接口参数
 *  @param success           成功回调
 *  @param failure           失败回调
 */
-(void)sendGETAPI:(NSString *)api authorizationType:(QMAuthorizationType)authorizationType params:(id)params success:(Success)success failure:(Failure)failure;


/**
 *  上传图片(项目)暂时废弃
 *
 *  @param api     接口名
 *  @param data    图片数据
 *  @param success 成功回调
 *  @param failure 失败回调
 */
//- (void)uploadAPI:(NSString *)api withData:(NSArray *)datas success:(Success)success failure:(Failure)failure;
@end
