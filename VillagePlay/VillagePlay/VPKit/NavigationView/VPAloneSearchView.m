//
//  VPAloneSearchView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAloneSearchView.h"
#import <Masonry.h>

@interface VPAloneSearchView ()


@property (nonatomic, copy) TapBlock tapBlock;

@end

@implementation VPAloneSearchView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layerUI];
    }
    return self;
}

- (void)layerUI{
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.backgroundColor = [[UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1.0] colorWithAlphaComponent:0.6];
    [self.searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.searchButton setTitle:@"搜索乡村/旅游/民宿/门票等" forState:UIControlStateNormal];
    [self.searchButton setImage:[UIImage imageNamed:@"vp_tab_search_white"] forState:UIControlStateNormal];
    self.searchButton.layer.cornerRadius = 4;
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.searchButton addTarget:self action:@selector(tapSearch) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.searchButton];
    
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

- (void)tapSearch{
    if(self.tapBlock){
        self.tapBlock();
    }
}

//- (void)layerUI{
//    button.frame = CGRectMake(0, 0, 285, 29);
//    //    [button setTitleColor:[UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0] forState:UIControlStateNormal];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
