//
//  VPNavigationRightBarView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPNavigationRightBarView.h"
#import "UIView+Frame.h"

@interface VPNavigationRightBarView ()

@property(strong, nonatomic)NSArray * images;

@end

@implementation VPNavigationRightBarView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        self.images =[NSArray array];
    }
    return self;
}

-(void)imageSource:(NSArray*)imageSource{

    self.images =imageSource;
    [self setUI];

}

-(void)setUI{

    CGFloat shareX=self.width-22;
    for (int i =0; i<self.images.count; i++) {
        
        UIButton * rightBarButton =[UIButton buttonWithType:UIButtonTypeCustom];
        rightBarButton.frame =CGRectMake(shareX, 11, 22, 22);
        [rightBarButton setImage:[[UIImage imageNamed:self.images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];

        rightBarButton.tag =i;
        [rightBarButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBarButton];
        shareX =shareX-(17+22);
    }
}

-(void)rightAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:sender.tag];
    }
}

@end
