//
//  QMUpdateAndPraise.h
//  PraiseAndUpdate
//
//  Created by Apricot on 2017/1/13.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIView;
#pragma mark - 更新模块
static NSString * updateMessage = @"小二又带了新的版本啦，赶紧更新去体验吧！(●ﾟωﾟ●)";
static NSString * updateConfirmTitle = @"立即更新";
static NSString * updateCancelTitle = @"下次提醒";
//显示更新的间隔时间 1天 (秒)
#define KUpdateTime ((24*60*60)*1)


#pragma mark - 好评模块
static NSString * praiseMessage = @"初次认识，对人家还满意吗？(◡.◡✿)";

static NSString * praiseConfirmTitle = @"满意，赏你个好评";
static NSString * praiseOtherTitle = @"还需要深入了解";
static NSString * praiseCancelTitle = @"挥泪拒绝";
//显示好评的间隔时间为30天 (秒)
#define KPraiseTime ((24*60*60)*30)

/**
 跳转的URL
 */
static NSString * openURL = @"https://itunes.apple.com/cn/app/xia-xiang-ke-zhou-mo-zhou/id963622843?mt=8";


@interface QMUpdateAndPraise : NSObject

+ (instancetype)sharedManager;


/**
 显示好评的视图
 */
- (void)showPraise;

/**
 显示提示更新的视图

 @param message 提示的消息
 @param isForced 是否强制更新
 */
- (void)showUpdateWithMessage:(NSString *)message isForced:(BOOL)isForced;
@end
