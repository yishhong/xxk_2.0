//
//  QMHeadView.h
//  VillagePlay
//
//  Created by Apricot on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHEIGHT 225.0f


@interface UIViewController ()

@end

@interface QMHeadView : UIView
@property (nonatomic, strong) UIImageView *imageView;

/**
 *  在ScrollView滑动事件中处理调用改方法实时更新
 *
 *  @param scrollView scrollView
 */
- (void)updateFrameWith:(UIScrollView *)scrollView;

@end
