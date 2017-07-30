//
//  UIApplication+System.m
//  VillagePlay
//
//  Created by Apricot on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIApplication+System.h"

@implementation UIApplication (System)
+ (void)callPhone:(NSString *)phoneNumber{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
}
+ (void)sendMessage:(NSString *)phoneNumber{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
}
@end
