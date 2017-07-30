//
//  VPGuidanceView.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//
#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)
#import "VPGuidanceView.h"
#import "UIView+Frame.h"

@interface VPGuidanceView ()

@property(strong, nonatomic) UILabel * titleLabel;

@property(strong, nonatomic) UILabel * detailLabel;

@property(strong, nonatomic) UIImageView * guidanceImageView;

@end

@implementation VPGuidanceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    UIImageView * guidanceImageView =[[UIImageView alloc]initWithFrame:CGRectMake(20, 90, 134, 15)];
    guidanceImageView.image =[UIImage imageNamed:@"xiaxiangke"];
    [self addSubview:guidanceImageView];
    
    UILabel * detailLabel =[[UILabel alloc]initWithFrame:CGRectMake(40, dtScreenHeight-105, dtScreenWidth-60, 16)];
    detailLabel.font =[UIFont systemFontOfSize:16];
    detailLabel.textAlignment =NSTextAlignmentLeft;
    detailLabel.textColor =[UIColor whiteColor];
    [self addSubview:detailLabel];
    self.detailLabel =detailLabel;
    
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, dtScreenHeight-(105+10+21), dtScreenWidth-40, 21)];
    titleLabel.font =[UIFont systemFontOfSize:21];
    titleLabel.textAlignment =NSTextAlignmentLeft;
    titleLabel.textColor =[UIColor whiteColor];
    [self addSubview:titleLabel];
    self.titleLabel =titleLabel;
}

-(void)setDictionary:(NSDictionary *)dictionary{

    _dictionary =dictionary;
    self.titleLabel.text =dictionary[@"title"];
    self.detailLabel.text =dictionary[@"detailTitle"];

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
