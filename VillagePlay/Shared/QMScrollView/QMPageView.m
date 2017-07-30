//
//  UIPageView.m
//  scrollView
//
//  Created by Apricot on 16/11/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMPageView.h"

@implementation QMPageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (void)layerUI{
    
    self.pageImageView = [[UIImageView alloc] init];
    self.pageImageView.image = [UIImage imageNamed:@"fox"];
    [self addSubview:self.pageImageView];
    
    self.lb_title = [[UILabel alloc] init];
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    self.lb_title.text = @"测试ceiling";
    [self addSubview:self.lb_title];
    
    self.pageImageView.frame = CGRectMake(0, 0, 200, 80);
    self.lb_title.frame = CGRectMake(0, CGRectGetMaxY(self.pageImageView.frame), CGRectGetWidth(self.pageImageView.frame), 20);
}

@end
