//
//  QMMediator.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMMediator.h"

@implementation QMMediator
+ (instancetype)sharedInstance{
    static QMMediator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
+ (UIViewController *)openURL:(NSString *)urlStr object:(NSDictionary *)object{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if([url.scheme isEqualToString:@"hotel"]){
        NSArray *objArray = [url.query componentsSeparatedByString:@"&"];
        NSMutableDictionary *objDict = [NSMutableDictionary dictionary];
        for (NSString *str in objArray) {
            NSRange range = [str rangeOfString:@"="];
            NSString *key = [str substringToIndex:range.location];
            NSString *value = [str substringFromIndex:range.location+1];
            [objDict setObject:value forKey:key];
        }
        Class subClass = NSClassFromString(url.host);
        //这里需要处理数据传入的问题 obj 初始化的不同的问题
        id obj = [subClass instantiation];
        if(!obj){
            return nil;
        }
        //传递参数部分
        for (NSString *key in objDict) {
            NSString *value = [objDict objectForKey:key];
            NSString *selector = [NSString stringWithFormat:@"%@",key];
            
            if([obj respondsToSelector:NSSelectorFromString(selector)]){
                [obj setValue:value forKey:key];
            }
        }
        //传递对象 疑惑中 两选一
        for (NSString *key in object) {
            NSString *value = [object objectForKey:key];
            NSString *selector = [NSString stringWithFormat:@"%@",key];
            
            if([obj respondsToSelector:NSSelectorFromString(selector)]){
                [obj setValue:value forKey:key];
            }
        }
        //传递对象
        if([obj respondsToSelector:NSSelectorFromString(@"setAssociatedObject:")]){
            [obj setValue:object forKey:@"associatedObject"];
        }
        return obj;
    }else{
        [[UIApplication sharedApplication] openURL:url];
    }
    return nil;
}
@end
