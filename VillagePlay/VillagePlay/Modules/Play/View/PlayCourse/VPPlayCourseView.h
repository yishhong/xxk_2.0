//
//  VPPlayCourseView.h
//  scrollView
//
//  Created by Apricot on 16/11/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectIndex)(NSIndexPath *indexPath, NSInteger section, NSInteger row);

@interface VPPlayCourseView : UIView

/**
 配置界面

 @param frame <#frame description#>
 */
- (void)layoutUIWithViewFrame:(CGRect)frame;

/**
 配置数据源

 @param array 数据组
 */
- (void)configDataSource:(NSArray *)array block:(SelectIndex)selectIndex;


/**
 显示（已内部使用）
 */
- (void)showAnimation;

/**
 隐藏（已内部使用）
 */
- (void)hideAnimation;

@end
