//
//  VPAdLaunchImageView.h
//  VillagePlay
//
//  Created by qineng on 16/2/16.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPAdLaunchImageView : UIImageView

@property (nonatomic, strong) UIImage *adImage;
@property (nonatomic, copy) void(^clickAdImageHandle)();

- (void)showInWindowAnimationDuration:(NSTimeInterval)duration;

@end
