//
//  QMRequestGeneratorWithPOST.m
//  QMAPIManage
//
//  Created by Apricot on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMRequestGeneratorWithPOST.h"
#import "NSDictionary+Params.h"
#import "NSArray+Params.h"


@implementation QMRequestGeneratorWithPOST

+ (instancetype)instantiation{
    return [[self alloc] init];
}

- (NSString *)HTTPMethod{
    return @"POST";
}

- (NSURLRequest *)HTTPBodyWithRequest:(NSURLRequest *)request withParams:(id)params{
//    NSString * paramsStr = [[params transformedUrlParams] paramsString];
//    request.HTTPBody = [paramsStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSMutableData *postData = [NSMutableData data];

    if([request.allHTTPHeaderFields[@"Content-Type"] isEqualToString:@"application/x-www-form-urlencoded"]){
        NSString * paramsStr = @"";
        
        if([params isKindOfClass:[NSDictionary class]]){
            paramsStr = [[params transformedUrlParams] paramsString];
        }else{
            paramsStr = [params paramsString];
        }
        [postData appendData:[paramsStr dataUsingEncoding:NSUTF8StringEncoding]];
    }else{
        if(params){
           postData = [[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil] mutableCopy];
        }
    }
    [mutableRequest setHTTPBody:postData];


    
    return mutableRequest;
}

@end
