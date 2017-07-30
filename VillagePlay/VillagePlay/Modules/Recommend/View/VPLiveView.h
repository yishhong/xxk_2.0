//
//  VPLiveView.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPLiveView : UIView

/**
 直播的页面
 */
@property (nonatomic, strong) UIImageView *livePhoto;

/**
 直播的标题
 */
@property (nonatomic, strong) UILabel *lb_title;

/**
 观看次数
 */
@property (nonatomic, strong) UILabel *lb_watch;

/**
 直播的状态的图标
 */
@property (nonatomic, strong) UIImageView *liveStateImage;

/**
 直播状态的文本
 */
@property (nonatomic, strong) UILabel *lb_liveState;
@end
