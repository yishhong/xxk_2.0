//
//  VPSearchModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

/*
 "pid": 1065,
 "title": "寻迹大围山·大围山森林公园1日游",
 "img": "/bigImages/20160930/cfe1c4cb-446c-4cd7-b371-79dba5a7c496.jpg",
 "price": "238元",
 "tag": "",
 "tagList": [],
 "count": 0,
 "allStar": 0,
 "personNum": 0,
 "actKeyword": null,
 "state": 2
 */
@interface VPSearchModel : VPBaseModel

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *tag;

/**
 这个用在民宿的评论数
 */
@property (nonatomic, assign) NSInteger count;

/**
 这个用在民宿总星数
 */
@property (nonatomic, assign) NSInteger allStar;


/**
 活动的报名人数
 */
@property (nonatomic, assign) NSInteger personNum;


/**
 用于区分活动的报名状态
 */
@property (nonatomic, assign) NSInteger state;

/**
 跟团游 等等
 */
@property (nonatomic, copy) NSString *actKeyword;

@property (nonatomic, strong) NSArray <NSString *>*tagList;

@end
