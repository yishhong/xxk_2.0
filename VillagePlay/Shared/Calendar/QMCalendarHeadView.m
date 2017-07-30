//
//  QMCalendarHeadView.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMCalendarHeadView.h"

@interface QMCalendarHeadView ()
@property (nonatomic, strong) UILabel *titleView;
@end

@implementation QMCalendarHeadView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
- (UILabel *)titleView{
    self.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];

    if(!_titleView){
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _titleView.textAlignment = NSTextAlignmentCenter;
//        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.backgroundColor = self.backgroundColor;
        _titleView.font = [UIFont systemFontOfSize:12];
        [self addSubview:_titleView];
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 0.5)];
//        lineView.backgroundColor = [UIColor colorWithRed:0.7804 green:0.7843 blue:0.7725 alpha:1.0];
//        [self addSubview:lineView];
    }
    return _titleView;
}

- (void)title:(NSString *)title{
    self.titleView.text = title;
}
@end
