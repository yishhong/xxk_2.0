//
//  VPLiveDetailViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLiveInfoModel.h"
#import "CommentDetaileEnum.h"

@interface VPLiveDetailViewModel : NSObject

/**
 渠道ID
 */
@property (assign, nonatomic)VPChannelType channelType;

/**
 直播ID
 */
@property (assign, nonatomic) NSInteger liveID;

-(void)liveDetailViewModel:(VPLiveInfoModel *)liveDetailViewModel;

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

/**
 直播添加评论

 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)liveAddCommendContent:(NSString *)content success:(void(^)())success failure:(void(^)(NSError * error))failure;

@end
