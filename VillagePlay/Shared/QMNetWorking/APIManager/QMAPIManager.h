//
//  QMAPIManager.h
//  QMAPIManage
//
//  Created by Apricot on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMAPIProxy.h"
@interface QMAPIManager : NSObject

+ (instancetype)sharedManager;

/**
 *  发送接口请求
 *
 *  @param api               接口名
 *  @param params            参数
 *  @param apiProxy          APIProxy 对象
 *  @param completionHandler 回调
 *
 *  @return 返回task的唯一标识
 */
- (NSUInteger)sendAPI:(NSString *)api withParams:(id)params withAPIProxy:(QMAPIProxy *)apiProxy completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 *  上传接口
 *
 *  @param api               <#api description#>
 *  @param data              <#data description#>
 *  @param apiProxy          <#apiProxy description#>
 *  @param completionHandler <#completionHandler description#>
 *
 *  @return <#return value description#>
 */
- (NSUInteger)uploadAPI:(NSString *)api withData:(NSData *)data withAPIProxy:(QMAPIProxy *)apiProxy completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
@end
