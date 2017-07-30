//
//  VPDestinationCityView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationCityView.h"
#import <Masonry.h>

@interface VPDestinationCityView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) TapBlock tapBlock;

@end

@implementation VPDestinationCityView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (void)layerUI{
    self.backgroundColor = [UIColor clearColor];
    
    //    self.backgroundColor = [UIColor navigationTintColor];
    
    if(!self.cityButton){
        self.cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cityButton.tag = 2;
        //    [self.cityButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        //    [self.cityButton setTitle:@"" forState:UIControlStateNormal];
        //    [self.searchButton setImage:[UIImage imageNamed:@"vp_tab_search_white"] forState:UIControlStateNormal];
        //    self.searchButton.layer.cornerRadius = 4;
        [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cityButton.titleLabel.font = [UIFont systemFontOfSize:26];
        [self.cityButton addTarget:self action:@selector(tapView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cityButton];
        self.cityButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
    }
    
    if(!self.imageView){
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"tab_arrow_bottom"];
        [self addSubview:self.imageView];
//        self.imageView.layer.borderWidth = 1;
    }
    
    
    [self.cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.imageView.mas_leading).offset(-3);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cityButton.mas_centerY).offset(0);
        make.leading.mas_equalTo(self.cityButton.mas_trailing).offset(3);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
}
- (void)layerUIBlock:(TapBlock)tapBlock{
    if(tapBlock){
        if(self.tapBlock){
            self.tapBlock = nil;
        }
        self.tapBlock = tapBlock;
    }
}

- (void)tapView:(UIButton *)button{
    if(self.tapBlock){
        self.tapBlock(button.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
