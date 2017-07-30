//
//  QMHeadView.m
//  VillagePlay
//
//  Created by Apricot on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMHeadView.h"
#import "Masonry.h"

@interface QMHeadView ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation QMHeadView

- (instancetype)init{
    self = [super init];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(self.mas_width);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    [self.imageView layoutIfNeeded];
    
    return self;
}

- (void)updateFrameWith:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -kHEIGHT) {
        CGRect rect = self.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        self.frame = rect;
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
