//
//  VPEditUserInfoViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPEditUserInfoViewModel.h"
#import "XXCellModel.h"
#import "VPUserAPI.h"
#import "VPQiNiuAPI.h"
#import "VPUserManager.h"
#import "NSError+Reason.h"


@interface VPEditUserInfoViewModel ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) VPUserAPI * userAPI;
@property (nonatomic, strong) VPQiNiuAPI * qiNiuAPI;

@end

@implementation VPEditUserInfoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.userModel = [[VPUserManager sharedInstance].xx_userInfo mutableCopy];
        self.userAPI = [[VPUserAPI alloc] init];
        self.qiNiuAPI = [[VPQiNiuAPI alloc] init];
    }
    return self;
}

- (void)layerUI{
    XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
    [self.dataSource addObject:spaceCellModel];
    //头像
    NSDictionary *photoInfo = [self cellDataSourceWithTitle:@"我的头像" key:@"" value:self.userModel placeholder:@"vp_headPhoto"];

    XXCellModel * photoCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoPhotoCell" height:85 dataSource:photoInfo action:@selector(photo:)];
    [self.dataSource addObject:photoCellModel];
    [self.dataSource addObject:spaceCellModel];
    
    //昵称
    NSDictionary *nickNameInfo = [self cellDataSourceWithTitle:@"昵称" key:@"nickname" value:self.userModel placeholder:@""];
    XXCellModel * nickNameCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoDataCell" height:45 dataSource:nickNameInfo action:nil];
    [self.dataSource addObject:nickNameCellModel];
    [self.dataSource addObject:spaceCellModel];

    //性别
    NSDictionary *sexInfo = [self cellDataSourceWithTitle:@"性别" key:@"sex" value:self.userModel placeholder:@"未设置"];
    XXCellModel * sexCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoDataCell" height:45 dataSource:sexInfo action:@selector(sex:)];
    [self.dataSource addObject:sexCellModel];
    [self.dataSource addObject:spaceCellModel];
    //个性签名
    NSDictionary *signInfo = [self cellDataSourceWithTitle:@"个性签名" key:@"signature" value:self.userModel placeholder:@"请填写个性签名"];
    XXCellModel * signCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoDataCell" height:45 dataSource:signInfo action:nil];
    [self.dataSource addObject:signCellModel];
    [self.dataSource addObject:spaceCellModel];
    //出生日期
    NSDictionary *birthDateInfo = [self cellDataSourceWithTitle:@"出生日期" key:@"birthday" value:self.userModel placeholder:@"未设置"];
    XXCellModel * birthDateCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoDataCell" height:45 dataSource:birthDateInfo action:@selector(birthday:)];
    [self.dataSource addObject:birthDateCellModel];
    [self.dataSource addObject:spaceCellModel];
    //所在地
    NSDictionary *locationInfo = [self cellDataSourceWithTitle:@"所在地" key:@"area" value:self.userModel placeholder:@"未设置"];
    XXCellModel * locationCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoDataCell" height:45 dataSource:locationInfo action:@selector(area:)];
    [self.dataSource addObject:locationCellModel];
    [self.dataSource addObject:spaceCellModel];
    //职业
    NSDictionary *careerInfo = [self cellDataSourceWithTitle:@"职业" key:@"occupation" value:self.userModel placeholder:@"未设置"];
    XXCellModel * careerCellModel = [XXCellModel instantiationWithIdentifier:@"VPUserInfoDataCell" height:45 dataSource:careerInfo action:@selector(occupation:)];
    [self.dataSource addObject:careerCellModel];
    [self.dataSource addObject:spaceCellModel];
    
}

- (void)selectPhotoImage:(UIImage *)photoImage{
    if(photoImage){
        self.userModel.smallHeadPhoto = photoImage;
    }
}

- (NSDictionary *)cellDataSourceWithTitle:(NSString *)title key:(NSString *)key value:(id)value placeholder:(NSString *)placeholder{
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    infoDict[@"title"] = title.length?title:@"";
    infoDict[@"key"] = key.length?key:@"";
    infoDict[@"value"] = value;
    infoDict[@"placeholder"] = placeholder.length?placeholder:@"";
    return infoDict;
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}


- (void)loadUserInfoSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    [self.userAPI loadUserInfoWithUserId:self.userModel.vid success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)updateUserInfoSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    

    NSDictionary *userInfoDict = [NSDictionary dictionaryWithDictionary:[self.userModel yy_modelToJSONObject]];
//    "photoUrl": "string",
//    "userphotoModel": [
//                       {
//                           "pid": "string",
//                           "photoUrl": "string",
//                           "bigphotoUrl": "string"
//                       }
//                       ],
//    "nickname": "string",
//    "provinceID": "string",
//    "cityID": "string",
//    "occupation": "string",
//    "interest": "string",
//    "personalSign": "string",
//    "birthdayDate": "string",
//    "sex": "string",
//    "userid": "string",
//    "hometown": "string",
//    "introduction": "string"
    NSMutableDictionary *params =  [NSMutableDictionary dictionaryWithDictionary:[self.userModel yy_modelToJSONObject]];
    //添加这些数据是因为后台的提交模型和用户模型不一致
    params[@"userid"] = self.userModel.vid;
    params[@"birthdayDate"] = self.userModel.birthday;
    params[@"personalSign"] = self.userModel.signature;
    params[@"photoUrl"] = self.userModel.smallHeadPhoto;
    
    if([self.userModel.smallHeadPhoto isKindOfClass:[UIImage class]]){
        [self.qiNiuAPI uploadImageWithImages:@[self.userModel.smallHeadPhoto] Success:^(NSArray *imageUrlArray) {
            self.userModel.smallHeadPhoto = [NSString stringWithFormat:@"http://image.xiaxiangke.com/%@",[imageUrlArray lastObject]];
            params[@"photoUrl"] = self.userModel.smallHeadPhoto;
            [self updateUserInfoWithParams:params Success:success failure:failure];
        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{
        [self updateUserInfoWithParams:params Success:success failure:failure];
    }


}
- (void)updateUserInfoWithParams:(NSDictionary *)params Success:(void (^)())success failure:(void (^)(NSError *))failure{
    [self.userAPI updateUserInfoWithParams:params success:^(NSDictionary *responseDict) {
        VPUserInfoModel *userinfo = [VPUserInfoModel yy_modelWithJSON:responseDict[@"body"]];
        if(userinfo.stateMessage.length<1||[userinfo.stateMessage isKindOfClass:[NSNull class]]){
            [[VPUserManager sharedInstance] xx_updateUserInfo:self.userModel];
            success();
        }else{
            NSError *error = [NSError errorMessage:@""];
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)key:(NSString *)key value:(NSString *)value{
    [self.userModel setValue:value forKey:key];
}

@end
