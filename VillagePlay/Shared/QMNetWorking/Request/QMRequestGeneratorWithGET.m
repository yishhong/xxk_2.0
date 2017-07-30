//
//  QMRequestGeneratorWithGET.m
//  QMAPIManage
//
//  Created by Apricot on 16/7/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMRequestGeneratorWithGET.h"
#import "NSDictionary+Params.h"
#import "NSArray+Params.h"

@implementation QMRequestGeneratorWithGET

+ (instancetype)instantiation{
    return [[self alloc] init];
}

- (NSString *)HTTPMethod{
    return @"GET";
}

- (NSURLRequest *)HTTPBodyWithRequest:(NSURLRequest *)request withParams:(id)params{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString * paramsStr = @"";
    if([params isKindOfClass:[NSDictionary class]]){
        paramsStr = [[params transformedUrlParams] paramsString];
    }else{
        paramsStr = [params paramsString];
    }
    if(paramsStr.length!=0){
        mutableRequest.URL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@?%@",request.URL.absoluteString,paramsStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return mutableRequest;
}
@end
