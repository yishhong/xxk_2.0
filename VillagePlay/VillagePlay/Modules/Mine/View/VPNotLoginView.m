//
//  VPNotLoginView.m
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPNotLoginView.h"
#import <Masonry.h>

typedef void(^ClickButtonBlock)(BOOL isRegister);


@interface VPNotLoginView ()
@property (nonatomic, copy) ClickButtonBlock clickButtonBlock;

@end

@implementation VPNotLoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (void)layerUI{
    UIButton *loginButton = [self createButtonWithTitle:@"登 录"];
    [self addSubview:loginButton];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIButton *registerButton = [self createButtonWithTitle:@"注 册"];
    [self addSubview:registerButton];
    [registerButton addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    width = (width/2.0)/2.0-84/5.0;
    width = 58.5;
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(84);
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX).offset(-width);
        
    }];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(loginButton.mas_height);
        make.width.mas_equalTo(loginButton.mas_width);
        make.centerY.mas_equalTo(loginButton.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX).offset(width);
    }];
}

- (void)clickEvent:(void (^)(BOOL isRegister))clickBlock{
    if(clickBlock){
        if(self.clickButtonBlock){
            self.clickButtonBlock = nil;
        }
        self.clickButtonBlock = clickBlock;
    }

}

- (UIButton *)createButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 1;
    return button;
}

- (void)login{
    self.clickButtonBlock(NO);
}

- (void)registerAccount{
    self.clickButtonBlock(YES);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
