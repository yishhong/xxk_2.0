//
//  VPHotelPopupTopView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelPopupTopView.h"
#import <Masonry.h>
#import "UIColor+HUE.h"

@interface VPHotelPopupTopView ()

@property (nonatomic, copy) CloseBlock closeBlock;

@end

@implementation VPHotelPopupTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layerUI];
    }
    return self;
}


- (void)layerUI{

    
    self.lb_title = [[UILabel alloc] init];
    self.lb_title.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.lb_title];
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor septalLineColor];
    [self addSubview:lineView];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(12);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.trailing.mas_equalTo(self.closeButton.mas_leading).offset(-10);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-12);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).offset(0);
    }];
}

- (void)closeView{
    if(self.closeBlock){
        self.closeBlock();
    }
}

- (void)tapClose:(CloseBlock)closeBlock{
    if(closeBlock){
        if(self.closeBlock){
            self.closeBlock = nil;
        }
        self.closeBlock = closeBlock;
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
