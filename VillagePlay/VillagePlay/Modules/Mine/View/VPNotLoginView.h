//
//  VPNotLoginView.h
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPNotLoginView : UIView

/**
 添加点击事件的回调

 @param clickBlock 回调
 */
- (void)clickEvent:(void (^)(BOOL isRegister))clickBlock;
@end
