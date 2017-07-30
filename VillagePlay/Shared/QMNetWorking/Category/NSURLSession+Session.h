//
//  NSURLSession+Session.h
//  QMAPIManage
//
//  Created by Apricot on 16/7/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession (Session)
- (NSURLSessionDataTask *)dataTaskWithApi:(NSString *)api withParams:(NSDictionary *)params completionHandler:(void(^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

- (NSURLSessionUploadTask *)uploadDataWithApi:(NSString *)api withData:(NSData *)data completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;
@end
