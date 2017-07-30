//
//  VPWeikanModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPMagazineModel : VPBaseModel


/**
 微刊ID
 */
@property (nonatomic, assign) NSInteger magazineID;

/**
 微刊标题
 */
@property (nonatomic, strong) NSString * title;

/**
 微刊简介
 */
@property (nonatomic, strong) NSString * desc;

/**
 图片
 */
@property (nonatomic, strong) NSString * photoUrl;

/**
 微刊URL
 */
@property (nonatomic, strong) NSString * magazineUrl;

/**
 ???
 */
@property (nonatomic, assign) NSInteger isSuggest;

/**
 时间
 */
@property (nonatomic, strong) NSString * releaseDate;

/**
 观看人数
 */
@property (nonatomic, assign) NSInteger viewNum;

/**
 评论数
 */
@property (nonatomic, assign) NSInteger commentNum;

/**
 是否推荐 0.默认 1.推荐
 */
@property (nonatomic, assign) NSInteger isTop;

/**
 浏览数
 */
@property (nonatomic, assign) NSInteger shareNum;

/**
 村ID
 */
@property (nonatomic, assign) NSInteger viliageID;




//
//"viewNum": null,
//"commentNum": null,
//"isTop": null,
//"shareNum": null,
//"viliageID": null
//"magazineID": 2,
//"title": "老汉任性歌",
//"description": "虽曰老汉，实数青年！不信，你听！不服，你看……",
//"photoUrl": "http://image.xiaxiangke.com//images/ViliageImg/magazineimage/2015722106166953416164656.jpg",
//"magazineUrl": "http://e.eqxiu.com/s/WoAKF2Hn?eqrcode=1&from=groupmessage&isappinstalled=0",
//"isSuggest": 1,
//"releaseDate": "2015-07-22 10:13:03"
@end
