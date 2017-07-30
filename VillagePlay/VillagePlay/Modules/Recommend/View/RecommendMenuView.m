//
//  RecommendMenuView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "RecommendMenuView.h"
#import <Masonry.h>
#import "UIColor+HUE.h"

@interface RecommendMenuView ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation RecommendMenuView

-(void)awakeFromNib{
    self.imageView =[[UIImageView alloc]init];

    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(13);
        make.size.mas_equalTo(CGSizeMake(49, 49));
    }];
    
    self.titleLabel =[[UILabel alloc]init];
    
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.titleLabel.font =[UIFont systemFontOfSize:14];
    self.titleLabel.textColor =[UIColor VPTitleColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.top.equalTo(self.imageView.mas_bottom).offset(7);
    }];
}

-(void)setDataSource:(NSDictionary *)dataSource{
    self.imageView.image = [UIImage imageNamed:dataSource[@"icon"]];
    self.titleLabel.text = dataSource[@"title"];
}

@end
