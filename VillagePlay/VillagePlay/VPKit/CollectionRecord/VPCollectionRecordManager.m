//
//  VPCollectionRecordManager.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCollectionRecordManager.h"
#import "VPStorageManager.h"
#import "NSError+Reason.h"
#import "VPUserManager.h"


@interface VPCollectionRecordManager ()

@property (nonatomic, strong) NSMutableDictionary * collectionRecordDict;

@end

@implementation VPCollectionRecordManager

//+ (instancetype)sharedManager {
//    static dispatch_once_t onceToken;
//    static id _shared;
//    dispatch_once(&onceToken, ^{
//        _shared = [[[self class] alloc] init];
//    });
//    return _shared;
//}
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.collectionRecordArray = [VPStorageManager loadCollectionRecord];
//    }
//    return self;
//}

- (NSArray *)collectionRecordWithType:(VPChannelType)type{
    //判断是否登录
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        return nil;
    }
    NSString *typeKey = [self keyWithType:type];
    [self verifyDictionaryWithTypeKey:typeKey];
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:self.collectionRecordDict[@"keys"]];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSString *key in keyArray) {
        [modelArray addObject:self.collectionRecordDict[key] ];
    }
    return modelArray;
}

- (void)addCollectionRecordWithType:(VPChannelType)type key:(NSString *)key model:(id)model block:(void (^)(NSError *, BOOL))block{
    //判断是否登录
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        NSError *error = [NSError errorCode:1024 message:@"还未登录le,让我收藏给谁0.0"];
        block(error,NO);
        return;
    }
    NSString *typeKey = [self keyWithType:type];
    [self verifyDictionaryWithTypeKey:typeKey];
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:self.collectionRecordDict[@"keys"]];
    if(![keyArray containsObject:key]){
        [keyArray insertObject:key atIndex:0];
        self.collectionRecordDict[@"keys"] = keyArray;
        self.collectionRecordDict[key] = model;
        [VPStorageManager saveCollectionRecord:self.collectionRecordDict type:typeKey];
    }
}



- (void)removeCollectionRecordWithType:(VPChannelType)type key:(NSString *)key block:(void (^)(NSError *, BOOL))block{
    //判断是否登录
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        NSError *error = [NSError errorCode:1024 message:@"你都未登录,你确定你收藏了0.0"];
        block(error,NO);
        return;
    }
    //通过对应的key
    NSString *typeKey = [self keyWithType:type];
    [self verifyDictionaryWithTypeKey:typeKey];
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:self.collectionRecordDict[@"keys"]];
    if([keyArray containsObject:key]){
        [keyArray removeObject:key];
        self.collectionRecordDict[@"keys"] = keyArray;
        [self.collectionRecordDict removeObjectForKey:key];
        [VPStorageManager saveCollectionRecord:self.collectionRecordDict type:typeKey];
    }
    
}

- (BOOL)isCollectionWithType:(VPChannelType)type key:(NSString *)key{
    //判断是否登录
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        return NO;
    }
    //开始判断对应的type 是否存在某个key
    NSString *typeKey = [self keyWithType:type];
    [self verifyDictionaryWithTypeKey:typeKey];
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:self.collectionRecordDict[@"keys"]];
    if([keyArray containsObject:key]){
        return YES;
    }
    return NO;
}

- (NSString *)keyWithType:(VPChannelType)type{
    NSString *key = @"";
    switch (type) {
            case VPChannelTypeVillage:{
                key = @"village";
            }break;
            case VPChannelTypeTicket:{
                key = @"ticket";
            }break;
            case VPChannelTypeHotel:{
                key = @"hotel";
            }break;
            case VPChannelTypeTravel:{
                key = @"travel";
            }break;
            case VPChannelTypeTopic:{
                key = @"topic";
            }break;
            case VPChannelTypeMagazine:{
                key = @"magazine";
            }break;
            case VPChannelTypePlay:{
                key = @"play";
            }break;
            case VPChannelTypeLive:{
                key = @"live";
            }break;
        default:{
            key = @"unknown";
        }break;
    }
    return key;
}

- (void)verifyDictionaryWithTypeKey:(NSString *)typeKey{
    if(!self.collectionRecordDict){
        self.collectionRecordDict = [NSMutableDictionary dictionaryWithDictionary:[VPStorageManager loadCollectionRecordWithType:typeKey]];
    }
    if(![self.collectionRecordDict.allKeys containsObject:@"keys"]){
        NSMutableArray *array = [NSMutableArray array];
        self.collectionRecordDict[@"keys"] = array;
    }
}

@end
