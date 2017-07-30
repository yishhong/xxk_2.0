//
//  VPLiveView.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveView.h"
#import <Masonry.h>
#import "UIColor+HUE.h"
#import "UIColor+HEX.h"

@interface VPLiveView ()
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation VPLiveView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.livePhoto = [[UIImageView alloc] init];
    self.livePhoto.layer.masksToBounds = YES;
    self.livePhoto.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.livePhoto];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:249.0/255.0 blue:251.0/255.0 alpha:1.0];
    [self addSubview:self.bottomView];
    //标题
    self.lb_title = [[UILabel alloc] init];
    self.lb_title.text = @"";
    self.lb_title.numberOfLines = 2;
    self.lb_title.font = [UIFont systemFontOfSize:14];
    [self.bottomView addSubview:self.lb_title];
    //观看次数
    self.lb_watch = [[UILabel alloc] init];
    self.lb_watch.text = @"";
    self.lb_watch.font = [UIFont systemFontOfSize:11];
    self.lb_watch.textColor = [UIColor colorWithHexString:@"9E9E9E"];
    [self.bottomView addSubview:self.lb_watch];
    //状态图标
    self.liveStateImage = [[UIImageView alloc] init];
    self.liveStateImage.image = [UIImage imageNamed:@"vp_live_begin"];
    [self.bottomView addSubview:self.liveStateImage];
    //状态文本
    self.lb_liveState = [[UILabel alloc] init];
    self.lb_liveState.text = @"";
    self.lb_liveState.font = [UIFont systemFontOfSize:11];
    self.lb_liveState.textColor = [UIColor navigationTintColor];
    [self.bottomView addSubview:self.lb_liveState];
    
    [self.livePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing);
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.livePhoto.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.bottomView.mas_trailing).offset(-5);
        make.leading.mas_equalTo(self.bottomView.mas_leading).offset(5);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(10);
    }];
    
    
    [self.lb_watch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.bottomView.mas_leading).offset(5);
        make.centerY.mas_equalTo(self.lb_liveState.mas_centerY);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-8);
    }];
    
    [self.liveStateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.lb_liveState.mas_leading).offset(-6);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(12);

    }];
    
    [self.lb_liveState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.bottomView.mas_trailing).offset(-5);
        make.centerY.mas_equalTo(self.liveStateImage.mas_centerY);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
