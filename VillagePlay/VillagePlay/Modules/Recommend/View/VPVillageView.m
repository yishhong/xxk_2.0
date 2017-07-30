//
//  VPVillageView.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVillageView.h"
#import <Masonry.h>
#import "UIColor+HUE.h"
#import "UIColor+HEX.h"

@interface VPVillageView ()
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation VPVillageView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.villagePhoto = [[UIImageView alloc] init];
    self.villagePhoto.layer.masksToBounds = YES;
    self.villagePhoto.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.villagePhoto];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:249.0/255.0 blue:251.0/255.0 alpha:1.0];
    [self addSubview:self.bottomView];
    //标题
    self.lb_title = [[UILabel alloc] init];
    self.lb_title.text = @"";
    self.lb_title.numberOfLines = 2;
    self.lb_title.font = [UIFont systemFontOfSize:14];
    [self.bottomView addSubview:self.lb_title];
    //距离
    self.lb_distance = [[UILabel alloc] init];
    self.lb_distance.text = @"";
    self.lb_distance.font = [UIFont systemFontOfSize:11];
    self.lb_distance.textColor = [UIColor colorWithHexString:@"9E9E9E"];
    [self.bottomView addSubview:self.lb_distance];
    
    [self.villagePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing);
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.villagePhoto.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.bottomView.mas_trailing).offset(-5);
        make.leading.mas_equalTo(self.bottomView.mas_leading).offset(5);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(10);
    }];
    
    [self.lb_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.bottomView.mas_leading).offset(5);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-8);
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
