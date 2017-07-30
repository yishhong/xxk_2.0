//
//  QMEventWithActionView.m
//  Calendar
//
//  Created by Apricot on 16/7/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMEventWithActionView.h"
#import "UIView+Mold.h"
@interface QMEventWithActionView ()
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UIButton * confirmBtn;

@end

@implementation QMEventWithActionView

- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = KFontSize;
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        _confirmBtn.titleLabel.font = KFontSize;
        [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithRed:0.1686 green:0.5608 blue:0.8353 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

- (void)setViews{
    //设置背景颜色
    self.backgroundColor = [UIColor colorWithRed:0.6471 green:0.6471 blue:0.6471 alpha:1.0];
    self.cancelBtn.frame = CGRectMake(0, 0.5, CGRectGetWidth(self.frame)/2.0000-0.25000, CGRectGetHeight(self.frame)-0.5);
    self.confirmBtn.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame)+0.5, CGRectGetMinY(self.cancelBtn.frame), CGRectGetWidth(self.cancelBtn.frame), CGRectGetHeight(self.cancelBtn.frame));
}

- (void)buttonTitleWith:(NSDictionary *)infoDict{
    /*
     @"leftButton":@"确认无房",
     @"rightButton":@"确认有房"
     */
    if([infoDict objectForKey:@"leftButton"]){
        [self.cancelBtn setTitle:infoDict[@"leftButton"] forState:UIControlStateNormal];
    }
    if([infoDict objectForKey:@"rightButton"]){
        [self.confirmBtn setTitle:infoDict[@"rightButton"] forState:UIControlStateNormal];
    }
}

#pragma mark - 点击事件区域
- (void)cancel{
    if([self.superview respondsToSelector:@selector(cancel)]){
        [self.superview cancel];
    }
}
- (void)confirm{
    if([self.superview respondsToSelector:@selector(confirm:)]){
        [self.superview confirm:nil];
    }
}


@end
