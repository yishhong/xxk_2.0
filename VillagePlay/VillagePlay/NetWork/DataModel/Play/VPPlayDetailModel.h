//
//  VPPlayDetailModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"
#import "VPPlayProductModel.h"

@interface VPPlayDetailModel : VPBaseModel
/*
 channelId = 1;
 currentDay = 2;
 introduce = "\U6e38\U73a9\U653b\U7565\U5185\U5bb9";
 products =     (
 {
 longitude = "26.084327,112.87387";
 picUrl = "/images/ViliageImg/181951884/bigimage/201532316868830018684333.jpg";
 pid = 68;
 price = "<null>";
 tag = ",\U6444\U5f71,\U9a91\U884c,\U730e\U5947,\U4e09\U53e4,";
 title = "\U677f\U6881\U6751\Uff1a\U6c49\U671d\U7687\U5ba4\U540e\U88d4\U805a\U96c6\U5730";
 },
 {
 longitude = "26.375844,110.14133";
 picUrl = "/images/ViliageImg/181901843/bigimage/20151059908445989081522.jpg";
 pid = 69;
 price = "<null>";
 tag = ",\U6c11\U4fd7,\U6444\U5f71,\U9057\U5740,\U4e09\U53e4,";
 title = "\U4e0a\U5821\U4f97\U5be8\Uff1a\U7238\U72383\U62cd\U6444\U5730";
 },
 {
 longitude = "25.970088,112.878647";
 picUrl = "/images/ViliageImg/181951882/bigimage/201582598158865418157091.jpg";
 pid = 70;
 price = "<null>";
 tag = ",\U6444\U5f71,\U9a91\U884c,\U730e\U5947,\U4e09\U53e4,";
 title = "\U5e99\U4e0b\U6751\Uff1a\U725b\U5e26\U6765\U7684\U660e\U6e05\U53e4\U6751";
 }
 );
 proids = "68|69|70";
 title = "\U6e38\U73a9\U653b\U7565";
 */

@property (nonatomic, copy) NSString *title;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString *proids;

/**
 内容
 */
@property (nonatomic, copy) NSString *introduce;

/**
 第几天
 */
@property (nonatomic, assign) NSInteger currentDay;

/**
 渠道
 */
@property (nonatomic, assign) NSInteger channelId;


/**
 推荐的村庄
 */
@property (nonatomic, strong) NSArray <VPPlayProductModel *>*products;

@end
