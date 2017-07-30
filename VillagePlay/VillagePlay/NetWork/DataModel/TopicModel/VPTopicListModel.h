//
//  VPTopicListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPTopicListModel : NSObject


/**
 *  专题ID
 */
@property(strong, nonatomic) NSString * projectID;

/**
 *  专题名
 */
@property(strong, nonatomic) NSString * projectName;

/**
 *  专题说明
 */
@property(strong, nonatomic) NSString * desc;

/**
 *  图片
 */
@property(strong, nonatomic) NSString * photoUrl;

/**
 *  查看次数
 */
@property(strong, nonatomic) NSString * praiseNum;

/**
 用户头像
 */
@property(strong, nonatomic) NSString * userHeadPhoto;

/**
 详情URL
 */
@property(strong, nonatomic) NSString * projectUrl;

/**
 专题时间
 */
@property(strong, nonatomic) NSString * creatDateTime;

/**
 用户状态
 */
@property(assign, nonatomic) NSInteger userState;

@end
