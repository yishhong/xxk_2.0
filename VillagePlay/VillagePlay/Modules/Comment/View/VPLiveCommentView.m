//
//  VPLiveCommentView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveCommentView.h"
#import "Masonry.h"
#import "UIColor+HUE.h"

@interface VPLiveCommentView ()<UITextFieldDelegate>

@property(strong, nonatomic)UITextField * liveTextField;

@end

@implementation VPLiveCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI{

    UIView * lineView =[[UIView alloc]init];
    lineView.backgroundColor =[UIColor controllerBackgroundColor];
    [self addSubview:lineView];
    
    UIButton * sendButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setImage:[UIImage imageNamed:@"vp__live_comment"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
    
    UITextField * liveTextField =[[UITextField alloc]init];
    UIView * leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 49, 22)];
    UIImageView * leftViewImage =[[UIImageView alloc]initWithFrame:CGRectMake(19, 0, 20, 22)];
    leftViewImage.image =[UIImage imageNamed:@"vp_send_comment"];
    [leftView addSubview:leftViewImage];
    liveTextField.leftView=leftView;
    liveTextField.leftViewMode =UITextFieldViewModeAlways;
    liveTextField.placeholder =@"我要说两句";
    liveTextField.font =[UIFont systemFontOfSize:13];
    liveTextField.borderStyle =UITextBorderStyleNone;
    liveTextField.layer.borderColor =[UIColor septalLineColor].CGColor;
    liveTextField.layer.borderWidth =1.0f;
    liveTextField.layer.cornerRadius =15.0f;
    liveTextField.layer.masksToBounds =YES;
    liveTextField.backgroundColor =[UIColor controllerBackgroundColor];
    [self addSubview:liveTextField];
    self.liveTextField =liveTextField;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    CGFloat textWidth =[UIScreen mainScreen].bounds.size.width-(10+20+19+20);
    [liveTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(textWidth);
        make.height.mas_equalTo(33);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(7);
    }];
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(22);
        make.right.equalTo(self).offset(-19);
        make.top.mas_equalTo(13);
    }];
}

-(void)sendeAction{

    if ([self.delegate respondsToSelector:@selector(commentContent:)]) {
        
        [self.delegate commentContent:self.liveTextField.text];
    }
    self.liveTextField.text=@"";
}

@end
