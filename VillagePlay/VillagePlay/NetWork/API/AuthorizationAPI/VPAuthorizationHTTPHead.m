//
//  HBAuthorizationHTTPHead.m
//  HotelBusiness
//
//  Created by Apricot on 16/9/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAuthorizationHTTPHead.h"
//base64
static NSString * Base64EncodedStringFromString(NSString *string) {
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        static uint8_t const kBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

@implementation VPAuthorizationHTTPHead

- (instancetype)init
{
    self = [super init];
    if (self) {
        //clientId == "xxkAppBusiness" && clientSecret == "qinengkeji1177")
        NSString *username = @"xxkApp";
        NSString * password = @"qinengkeji1177";
        NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", username, password];
        
        self.httpHead[@"Authorization"] = [NSString stringWithFormat:@"Basic %@",Base64EncodedStringFromString(basicAuthCredentials)];
        self.httpHead[@"Content-Type"] = @"application/x-www-form-urlencoded";
    }
    return self;
}
@end
