//
//  VPTravelMainViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentDetaileEnum.h"

@interface VPTravelMainViewModel : NSObject


/**
 旅游顶部tag标签

 @param channelId 频道ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelTagschannelId:(VPChannelType)channelId success:(void(^)(NSArray *travelTagsArray))success failure:(void(^)(NSError * error))failure;

@end
