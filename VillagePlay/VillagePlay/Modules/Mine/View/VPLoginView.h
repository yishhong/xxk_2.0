//
//  VPLoginView.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPLoginView : UIView

/**
 *  显示登录后的用户信息
 *
 *  @param dataModel  用户Model
 *  @param clickBlock 点击头像的点击事件回调
 */
- (void)loadData:(id)dataModel block:(void (^)())clickBlock;

@end
