//
//  VPLoginView.m
//  VillagePlay
//
//  Created by Apricot on 16/11/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLoginView.h"
#import "UIImageView+VPWebImage.h"
#import <Masonry.h>
#import "UIColor+HUE.h"
#import "VPUserInfoModel.h"

typedef void(^ClickPhotoBlock)();

@interface VPLoginView ()

@property (nonatomic, strong) VPUserInfoModel *userInfoModel;

@property (nonatomic, copy) ClickPhotoBlock clickPhotoBlock;

/**
 头像
 */
@property (nonatomic, strong) UIImageView * photoImageView;

/**
 昵称
 */
@property (nonatomic, strong) UILabel *lb_name;

/**
 等级
 */
@property (nonatomic, strong) UILabel *lb_level;

/**
 简介
 */
@property (nonatomic, strong) UILabel *lb_description;

@end

@implementation VPLoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (void)layerUI{
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUserPhoto)];
    self.photoImageView.userInteractionEnabled = YES;
    [self.photoImageView addGestureRecognizer:tap];
    
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.photoImageView.layer.borderWidth = 1;
    self.photoImageView.layer.cornerRadius = 28;
    self.photoImageView.layer.masksToBounds = YES;
    [self addSubview:self.photoImageView];
    
    self.lb_name = [self createLabel];
    [self addSubview:self.lb_name];
    
    self.lb_level = [[UILabel alloc] init];
    self.lb_level.textColor = [UIColor whiteColor];
    self.lb_level.backgroundColor = [UIColor navigationTintColor];
    self.lb_level.layer.cornerRadius = 2;
    self.lb_level.layer.masksToBounds = YES;
    self.lb_level.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.lb_level];
#warning 等级目前版本隐藏
    self.lb_level.hidden = YES;
    
    self.lb_description = [self createLabel];
    self.lb_description.font = [UIFont systemFontOfSize:13];
    self.lb_description.numberOfLines = 2;
    [self addSubview:self.lb_description];
    
    //头像
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        //        make.top.equalTo(loginView).top.offset(64+22);
        //        make.top.mas_equalTo(22);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-29.5);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(56);
    }];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(40);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-40);
        make.top.mas_equalTo(self.photoImageView.mas_bottom).offset(8);
        make.height.mas_equalTo(self.lb_description.mas_height);
    }];
    
    [self.lb_level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.lb_name.mas_centerY);
        make.leading.mas_equalTo(self.lb_name.mas_trailing).offset(8);
        make.height.mas_equalTo(15);
    }];
    
    [self.lb_description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.lb_name.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.lb_name.mas_trailing).offset(0);
        make.top.mas_equalTo(self.lb_name.mas_bottom).offset(0);
        make.height.mas_equalTo(self.lb_name.mas_height);
        make.width.mas_equalTo(self.lb_name.mas_width);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-6);
    }];
}

- (void)loadData:(id)dataModel block:(void (^)())clickBlock{
    if(clickBlock){
        if(self.clickPhotoBlock){
            self.clickPhotoBlock = nil;
        }
        self.clickPhotoBlock = clickBlock;
    }
    self.userInfoModel = dataModel;
    
    [self.photoImageView xx_setImageWithURLStr:self.userInfoModel.smallHeadPhoto placeholder:[UIImage imageNamed:@"vp_headPhoto"]];

    self.lb_name.text = self.userInfoModel.nickname;
    self.lb_level.text = @" VIP1 ";
    self.lb_description.text = self.userInfoModel.signature.length>0?self.userInfoModel.signature:@"这家伙很懒,什么也没有留下~";
}


/**
 点击头像
 */
- (void)touchUserPhoto{
    self.clickPhotoBlock();
}

- (UILabel *)createLabel{
    UILabel *label = [[UILabel alloc] init];
    label.font =[UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
