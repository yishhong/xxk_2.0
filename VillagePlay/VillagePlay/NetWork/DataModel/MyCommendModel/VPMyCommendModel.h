//
//  VPMyCommendModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPMyCommendModel : VPBaseModel
/*
 "commendID": "5519",
 "commendType": "7",
 "vid": "2943",
 "content": "testgood",
 "userID": "28583",
 "createDate": "2016-12-13 15:04:58",
 "theme": "来自直播:",
 "photoUrl": null,
 "smallHeadPhoto": null,
 "imgs": [],
 "nickname": "456"
 */

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString * commendID;

/**
 评论的类型 与渠道ID一致
 */
@property (nonatomic, copy) NSString * commendType;

@property (nonatomic, copy) NSString * vid;

/**
 内容
 */
@property (nonatomic, copy) NSString * content;

/**
 用户ID
 */
@property (nonatomic, copy) NSString * userID;

/**
 创建时间
 */
@property (nonatomic, copy) NSString * createDate;

/**
 来源
 */
@property (nonatomic, copy) NSString * theme;

/**
 头像
 */
@property (nonatomic, copy) NSString * photoUrl;

@property (nonatomic, copy) NSString * smallHeadPhoto;
@property (nonatomic, strong) NSArray *imgs;

/**
 昵称
 */
@property (nonatomic, copy) NSString *nickname;

@end
