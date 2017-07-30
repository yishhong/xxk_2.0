//
//  VPCityListHeadView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCityListHeadView.h"
#import <Masonry.h>
@implementation VPCityListHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.lb_title = [[UILabel alloc] init];
    [self addSubview:self.lb_title];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(12);
        make.trailing.mas_equalTo(self).offset(12);
        make.top.mas_equalTo(self).offset(0);
        make.bottom.mas_equalTo(self).offset(0);
    }];
    self.lb_title.font = [UIFont systemFontOfSize:12];
    self.lb_title.textColor = [UIColor colorWithRed:158.0/255.0 green:158.0/255.0 blue:158.0/255.0 alpha:1.0];
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
