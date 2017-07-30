//
//  UIBarButtonItem+Custom.m
//  VillagePlay
//
//  Created by Apricot on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)
- (void)xx_setFont:(UIFont *)font{
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font ,NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)xx_setFontSize:(CGFloat)size{
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:size],NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)xx_barButtonTitleFont{
    [self xx_setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15]];
}
@end
