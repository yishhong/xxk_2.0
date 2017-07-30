//
//  VPTopicDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPTopicDetailModel.h"

@interface VPTopicDetailViewModel : NSObject

/**
 *  专题详情
 *
 *  @param topicID 专题ID
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)topicID:(NSString *)topicID success:(void(^)(VPTopicDetailModel *TopicDetailModel))success failure:(void(^)(NSError * error))failure;

-(void)topicDetailViewModel:(NSArray *)topicDetailViewModel;

/**
 *  返回Cell行数
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取cell的详细信息
 *
 *  @param row     row坐标
 *  @param section section坐标
 *
 *  @return 返回指定的cell的详细信息
 */

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
