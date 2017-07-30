//
//  VPStorageManager.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPStorageManager.h"
#import "QMStorageManage.h"
#import <YYModel.h>

/**
 *  登录信息的KEY
 */
static NSString * const KLoginInfo = @"K_LoginInfo";

/**
 *  用户信息的KEY
 */
static NSString * const KUserInfo = @"K_UserInfo";

/**
 *  授权Token的KEY
 */
static NSString * const KAuthorization = @"K_Authorization";

/**
 *  收藏记录的KEY
 */
static NSString * const KCollectionRecord = @"K_CollectionRecord";

/**
 *  广告启动页记录的KEY
 */
static NSString * const KStartPage = @"K_StartPage";

/**
 *  选择城市记录的KEY
 */
static NSString * const KSelectCity = @"K_SelectCity";
/**
 *  搜索记录的KEY
 */
static NSString * const KSearchRecord = @"K_SearchRecord";


@interface VPStorageManager ()

@end


@implementation VPStorageManager

+ (void)saveLoginInfo:(NSDictionary *)loginInfo{
    [[QMStorageManage sharedManager].commonDB setObject:loginInfo forKey:KLoginInfo];
}

+ (NSDictionary *)loadLoginInfo{
    return [[QMStorageManage sharedManager].commonDB objectForKey:KLoginInfo];
}

+ (void)deleteLoginInfo{
    [[QMStorageManage sharedManager].commonDB removeObjectForKey:KLoginInfo];
}

+ (void)saveUserInfo:(VPUserInfoModel *)userInfoModel{
    /*
     "sysUserId": 1,
     "sysUserName": "admin"
     */
    [[QMStorageManage sharedManager].commonDB setObject:[userInfoModel yy_modelToJSONObject] forKey:KUserInfo];
    
    [[QMStorageManage sharedManager] loadUserDB:userInfoModel.vid];
}

+ (VPUserInfoModel *)loadUserInfo{
    id userDict = [[QMStorageManage sharedManager].commonDB objectForKey:KUserInfo];
    if(userDict){
        VPUserInfoModel * userInfoModel = [VPUserInfoModel yy_modelWithDictionary:userDict];
        [[QMStorageManage sharedManager] loadUserDB:userInfoModel.vid];
        return userInfoModel;
    }
    return nil;
}

+ (void)deleteUserInfo{
    [[QMStorageManage sharedManager].commonDB removeObjectForKey:KUserInfo];
    //清理用户的数据库
    [[QMStorageManage sharedManager] cleanUserDB];
}

+ (void)saveAuthorization:(NSDictionary *)authorization{
    [[QMStorageManage sharedManager].commonDB setObject:authorization forKey:KAuthorization];
}

+ (NSDictionary *)loadAuthorization{
    return [[QMStorageManage sharedManager].commonDB objectForKey:KAuthorization];
}

+ (void)deleteAuthorization{
    [[QMStorageManage sharedManager].commonDB removeObjectForKey:KAuthorization];
}

+ (void)saveCollectionRecord:(NSDictionary *)collectionRecord type:(NSString *)type{
    [[QMStorageManage sharedManager].userDB setObject:collectionRecord forKey:[NSString stringWithFormat:@"%@%@",KCollectionRecord,type]];
}

+ (NSDictionary *)loadCollectionRecordWithType:(NSString *)type{
    return [[QMStorageManage sharedManager].userDB objectForKey:[NSString stringWithFormat:@"%@%@",KCollectionRecord,type]];
}

+ (void)deleteCollectionRecordWithType:(NSString *)type{
    [[QMStorageManage sharedManager].userDB removeObjectForKey:[NSString stringWithFormat:@"%@%@",KCollectionRecord,type]];
}

+ (void)saveStartPageInfo:(VPBannerInfoModel *)startPageInfo{
    [[QMStorageManage sharedManager].commonDB setObject:[startPageInfo yy_modelToJSONObject] forKey:KStartPage];
}

+ (VPBannerInfoModel *)loadStartPageInfo{
    NSDictionary *startPageDict = [[QMStorageManage sharedManager].commonDB objectForKey:KStartPage];
    if(startPageDict){
        VPBannerInfoModel * bannerInfoModel = [VPBannerInfoModel yy_modelWithDictionary:startPageDict];
        return bannerInfoModel;
    }
    return nil;
}

+ (void)deleteStartPageInfo{
    [[QMStorageManage sharedManager].commonDB removeObjectForKey:KStartPage];
}

+ (void)saveSelectCityDict:(NSDictionary *)cityDict{
    [[QMStorageManage sharedManager].commonDB setObject:cityDict forKey:KSelectCity];
}

+ (NSDictionary *)loadCityDict{
    return [[QMStorageManage sharedManager].commonDB objectForKey:KSelectCity];
}

+ (void)deleteCityDict{
    [[QMStorageManage sharedManager].commonDB removeObjectForKey:KSelectCity];
}

+ (void)saveSearchRecord:(NSString *)searchRecord{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[QMStorageManage sharedManager].commonDB objectForKey:KSearchRecord]];
    [array addObject:searchRecord];
    [[QMStorageManage sharedManager].commonDB setObject:array forKey:KSearchRecord];
}

+ (NSArray *)loadSearchRecord{
    NSMutableArray *searchRecord = [[QMStorageManage sharedManager].commonDB objectForKey:KSearchRecord];
    return searchRecord;
}

+ (void)deleteSearchRecord{
    [[QMStorageManage sharedManager].commonDB removeObjectForKey:KSearchRecord];
}

@end
