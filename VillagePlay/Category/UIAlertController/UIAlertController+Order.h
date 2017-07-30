//
//  UIAlertController+Order.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Order)

/**
 警告框

 @param message 提示信息
 @param deleteString 按钮状态
 @param block <#block description#>
 @return <#return value description#>
 */
+ (instancetype)selectOrderStateMessage:(NSString *)message deleteString:(NSString *)deleteString block:(void(^)(NSInteger index))block;

@end
