//
//  QMAPIProxy.h
//  QMAPIManage
//
//  Created by Apricot on 16/7/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMHTTPHead.h"
#import "QMRequestGenerator.h"
#import "QMRequestConfiguration.h"

@interface QMAPIProxy : NSObject

+ (instancetype)instantiation;

/**
 *  配置HTTPHead 请求head头
 *
 *  @return <#return value description#>
 */
- (Class)HTTPHead;

/**
 *  配置请求的方式（POST GET等等）
 *
 *  @return <#return value description#>
 */
- (Class)requestGenerator;

/**
 *  默认的配置要求
 *
 *  @return <#return value description#>
 */
- (Class)requestConfiguration;

/**
 *  POST请求
 *
 *  @param api     <#api description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)PostAPI:(NSString *)api withParams:(id)params success:(void(^)(NSDictionary *body))success failure:(void(^)(NSError *error))failure;

/**
 *  GET请求
 *
 *  @param api     <#api description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)GetAPI:(NSString *)api withParams:(id)params success:(void(^)(NSDictionary *body))success failure:(void(^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param api     <#api description#>
 *  @param data    <#data description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)uploadFileWithAPI:(NSString *)api withData:(NSData *)imageData success:(void(^)(NSDictionary *body))success failure:(void(^)(NSError *error))failure;

- (void)addTaskIdentifier:(NSUInteger)kidentifier;
- (void)cancel;


@end
