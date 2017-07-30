//
//  VPAdLaunchImageView.m
//  VillagePlay
//
//  Created by qineng on 16/2/16.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "VPAdLaunchImageView.h"

@interface VPAdLaunchImageView ()

@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *skipButton;

@end

@implementation VPAdLaunchImageView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        
        [self addSingleTapGesture];
        [self addSubview:self.adImageView];
        [self addSubview:self.skipButton];
        
    }
    return self;
}

- (void)addSingleTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:singleTap];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _adImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.85);
}

- (void)showInWindowAnimationDuration:(NSTimeInterval)duration
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.adImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.skipButton.hidden = NO;
        [self startCountDownHideTimeDuration:duration];
    }];
}

- (void)removeSelfFromSuperview{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)startCountDownHideTimeDuration:(NSTimeInterval)duration{
    
    [self.skipButton setTitle:[NSString stringWithFormat:@"跳过 %@", @(duration)] forState:UIControlStateNormal];
    __block NSInteger timeOut = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeSelfFromSuperview];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.skipButton setTitle:[NSString stringWithFormat:@"跳过 %@", @(timeOut)] forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark -- Events Response
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture
{
    if (self.clickAdImageHandle) {
        [self removeSelfFromSuperview];
        self.clickAdImageHandle();
    }
}

- (void)didTappedSkipButton:(UIButton *)button
{
    [self removeSelfFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    BOOL skip = CGRectContainsPoint(_skipButton.frame, point);
    BOOL ad = CGRectContainsPoint(_adImageView.frame, point);
    
    if (self.hidden == NO && _adImageView.alpha > 0 && skip) {
        return _skipButton;
    }
    
    if (self.hidden == NO &&
        _adImageView.alpha > 0 &&
        ad &&
        !skip
        ){
        return self;
    }
    return nil;
}

#pragma mrak -- Setter && Getter
- (void)setAdImage:(UIImage *)adImage
{
    _adImage = adImage;
    
    self.adImageView.alpha = 0.0;
    self.adImageView.image = adImage;
}


- (UIImageView *)adImageView
{
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
    }
    return _adImageView;
}

- (UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-75, 15, 60, 30)];
        _skipButton.layer.cornerRadius = 3;
        _skipButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(didTappedSkipButton:) forControlEvents:UIControlEventTouchDown];
        _skipButton.hidden = YES;
    }
    return _skipButton;
}

@end
