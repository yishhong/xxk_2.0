//
//  VPSubSearchView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSubSearchView.h"
#import <Masonry.h>
#import "UIColor+HUE.h"
#import "UIColor+HEX.h"

@interface VPSubSearchView ()

@property (nonatomic, copy) TapBlock tapBlock;

@end

@implementation VPSubSearchView

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
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor navigationTintColor].CGColor;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
//    self.backgroundColor = [UIColor navigationTintColor];
    
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.tag = 2;
    [self.searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.searchButton setTitle:@"酒店/客栈/地名" forState:UIControlStateNormal];
    //    [self.searchButton setImage:[UIImage imageNamed:@"vp_tab_search_white"] forState:UIControlStateNormal];
    //    self.searchButton.layer.cornerRadius = 4;
    [self.searchButton setTitleColor:[UIColor colorWithHexString:@"9E9E9E"] forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.searchButton addTarget:self action:@selector(tapView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    
    self.backgroundColor = [UIColor colorWithHexString:@"D0F3F8"];
    
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).offset(0);
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