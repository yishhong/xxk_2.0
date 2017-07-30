//
//  VPSysMessageModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPSysMessageModel : VPBaseModel
/*
 "guid": "03f577d5c1e0443b8a4946613ec5320c",
 "title": "标题标题",
 "content": "测试测试测试",
 "isread": true,
 "type": "1",
 "sendId": "0",
 "sendName": "管理员",
 "toId": "28583",
 "toName": "18675760522",
 "url": "",
 "imgUrl": "",
 "dateTime": "2016-12-16 11:40:36",
 "dateTimeStr": "2016-12-16 11:40:36"
 */
@property (nonatomic, strong) NSString *guid;

/**
 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 内容
 */
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL isread;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sendId;
@property (nonatomic, strong) NSString *sendName;
@property (nonatomic, strong) NSString *toId;
@property (nonatomic, strong) NSString *toName;

/**
 打开内容的URL
 */
@property (nonatomic, strong) NSString *url;

/**
 展示图片
 */
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSString *dateTimeStr;
@end
