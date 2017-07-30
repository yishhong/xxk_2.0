//
//  QMWarnActionView.m
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMWarnActionView.h"
#import "UIView+Mold.h"
#import "QMEventWithActionView.h"

@interface QMWarnActionView ()
@property (nonatomic, strong) UILabel *warnLabel;
@property (nonatomic, strong) QMEventWithActionView *eventView;
@property (nonatomic, strong) NSDictionary *details;
@end

@implementation QMWarnActionView
- (instancetype)initWithDetails:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        self.details = details;
    }
    return self;
}

- (UILabel *)warnLabel{
    if (!_warnLabel) {
        _warnLabel = [[UILabel alloc] init];
        _warnLabel.font = KFontSize;
        _warnLabel.textColor = [UIColor blackColor];
        _warnLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_warnLabel];
    }
    return _warnLabel;
}

- (QMEventWithActionView *)eventView{
    if(!_eventView){
        _eventView = [[QMEventWithActionView alloc] init];
        [_eventView buttonTitleWith:self.details];
        [self addSubview:_eventView];
    }
    return _eventView;
}

- (void)setViews{
    self.warnLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.60000);
    self.warnLabel.text = self.details[@"title"];
    self.eventView.frame = CGRectMake(0, CGRectGetMaxY(self.warnLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.4);
    [self.eventView setViews];
}
- (void)cancel{
    NSLog(@"QMWarnActionView取消");
    if([self.superview respondsToSelector:@selector(cancel)]){
        [self.superview cancel];
    }
}

- (void)confirm:(id)object{
    NSLog(@"QMWarnActionView确定");
    if([self.superview respondsToSelector:@selector(confirm:)]){
        [self.superview confirm:nil];
    }
}
@end
