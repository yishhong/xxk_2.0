//
//  UIAlertController+Order.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIAlertController+Order.h"

@implementation UIAlertController (Order)

+ (instancetype)selectOrderStateMessage:(NSString *)message deleteString:(NSString *)deleteString block:(void (^)(NSInteger))block{

    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction  * alertCancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        block(0);
    }];
    UIAlertAction * deleteAction =[UIAlertAction actionWithTitle:deleteString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block(1);
    }];
    [alertController addAction:alertCancelAction];
    [alertController addAction:deleteAction];
    return alertController;
}

@end
