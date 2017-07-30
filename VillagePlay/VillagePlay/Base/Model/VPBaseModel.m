//
//  VPBaseModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@implementation VPBaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

- (id)mutableCopyWithZone:(nullable NSZone *)zone {return [self yy_modelCopy];}

@end
