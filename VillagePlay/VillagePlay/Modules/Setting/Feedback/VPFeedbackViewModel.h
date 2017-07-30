//
//  VPFeedbackViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPFeedbackViewModel : NSObject

- (void)submitAdviceContents:(NSString *)contents success:(void(^)())success failure:(void(^)(NSError * error))failure;

@end
