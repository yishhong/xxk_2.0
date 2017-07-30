//
//  QMStorageManage.m
//  HotelBusiness
//
//  Created by Apricot on 16/9/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMStorageManage.h"
#import "InfoPlist.h"
//#import <CocoaLumberjack/CocoaLumberjack.h>
#define DatabaseVersion @"DatabaseVersion"
@implementation QMStorageManage
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static id _shared;
    dispatch_once(&onceToken, ^{
        _shared = [[[self class] alloc] init];
    });
    return _shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.commonDB =[LevelDB databaseInLibraryWithName:@"AppCommon"];
    }
    return self;
}

- (void)loadUserDB:(NSString *)userName {
    //    DDLogInfo(@"user db setup(%@)", userName);
    
    self.userDB = [LevelDB databaseInLibraryWithName:userName];
    
    NSInteger dbVer = [self dbVersion];
    NSInteger ver = [InfoPlist dbVersion] ;
    
    if(dbVer < ver)
    {
        if (self.userDB) {
            [self.userDB removeAllObjects];
        }
        [self setDbVersion:ver];
    }
}

- (void)closeUserDB{
    if (!self.userDB.closed) {
        [self.userDB close];
    }
}

- (void)cleanUserDB{
    if (!self.userDB.closed) {
        [self.userDB removeAllObjects];
        [self.userDB close];
    }
}

- (void)cleanDB {
    if (self.commonDB &&
        !self.commonDB.closed) {
        [self.commonDB removeAllObjects];
    }
    if (self.userDB &&
        !self.userDB.closed) {
        [self.userDB removeAllObjects];
    }
}

- (NSInteger)dbVersion
{
    NSNumber *ver = [self.commonDB objectForKey:DatabaseVersion];
    if(ver)
    {
        return [ver integerValue];
    }
    
    return -1;
}

- (void)setDbVersion:(NSInteger)dbVersion
{
    [self.commonDB setObject:@(dbVersion) forKey:DatabaseVersion];
}

- (void)checkDbVersion
{
    NSInteger dbVer = [self dbVersion];
    NSInteger ver = [InfoPlist dbVersion] ;
    
    if(dbVer < ver && dbVer != -1)
    {
        [self.commonDB removeAllObjects];
    }
}
@end
