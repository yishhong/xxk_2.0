//
//  QMTextActionView.m
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//  文本输入

#import "QMTextActionView.h"
#import "UIView+Mold.h"
#import "QMEventWithActionView.h"

@interface QMTextActionView ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) QMEventWithActionView *eventView;
@property (nonatomic, strong) NSDictionary *details;
@end

@implementation QMTextActionView

- (instancetype)initWithDetails:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        self.details = details;
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFontSize;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = self.details[@"placeholder"];
        _textField.font = KFontSize;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [UIColor colorWithRed:0.851 green:0.851 blue:0.851 alpha:1.0].CGColor;
        _textField.layer.borderWidth = 1;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        _textField.leftView = paddingView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        
        _textField.delegate = self;
        [self addSubview:_textField];
    }
    return _textField;
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
    self.titleLabel.frame = CGRectMake(15, 0, CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)*0.3000);
    self.titleLabel.text = self.details[@"title"];
    
    self.textField.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame)+CGRectGetHeight(self.frame)*0.05000, CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)*0.25000);
    
    self.eventView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame)+CGRectGetHeight(self.frame)*0.10000, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.30000);
    [self.eventView setViews];
}

- (void)cancel{
    if([self.superview respondsToSelector:@selector(cancel)]){
        [self.superview cancel];
    }
}

- (void)confirm:(id)object{
    [self.textField resignFirstResponder];
    if([self.superview respondsToSelector:@selector(confirm:)]){
        [self.superview confirm:self.textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

@end
