//
//  VPLoginManager.h
//  VillagePlay
//
//  Created by Apricot on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    VPLoginTypeAccount  =   1,
    VPLoginTypeWechat,
    VPLoginTypeSina,
    VPLoginTypeQQ,
} VPLoginType;

@interface VPLoginManager : NSObject

+ (instancetype)instantiation;

- (void)loginWithType:(VPLoginType)loginType params:(NSDictionary *)params;

@end
