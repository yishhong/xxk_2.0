//
//  HBGravityImageView.m
//  HGLabyrinthDemo
//
//  Created by  易述宏 on 16/8/16.
//  Copyright © 2016年 湖南同禾. All rights reserved.
//

#import "HBGravityImageView.h"
#import "HBGravity.h"
#import <Masonry.h>

#define SPEED 50

@implementation HBGravityImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)awakeFromNib{
    [self configUI];
}
-(void)configUI{

    UIImageView * imageView =[[UIImageView alloc]init];
    [self addSubview:imageView];
    self.imageView =imageView;
}

-(void)setImage:(UIImage *)image{

    _image =image;
    self.imageView.image=image;
    [self.imageView sizeToFit];
    
    self.imageView.frame =CGRectMake (0, 0, self.frame.size.height *(self.imageView.frame.size.width / self.imageView.frame.size.height), self.frame.size.height);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(-10, -10, -10, -10));
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    [self.imageView setNeedsLayout];
}

-(void)startAnimation{

    float scrollSpeedWidth = (self.imageView.frame.size.width - self.frame.size.width)/2/SPEED;
//    float scrollSpeedHeight = (self.imageView.frame.size.height - self.frame.size.height)/2/SPEED;

    [HBGravity sharedGravity].timeInterval =0.03;
    [[HBGravity sharedGravity]startGyroUpdatesBlock:^(float x, float y, float z) {
        
        [UIView animateKeyframesWithDuration:0.6 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
            if (self.imageView.frame.origin.x <=0 && self.imageView.frame.origin.x >= self.frame.size.width - self.imageView.frame.size.width){
                
                float invertedYRotationRate = y * -1.0;
                float interpretedXOffset = self.imageView.frame.origin.x + invertedYRotationRate * (self.imageView.frame.size.width/[UIScreen mainScreen].bounds.size.width) * scrollSpeedWidth + self.imageView.frame.size.width/2;
                
                self.imageView.center = CGPointMake(interpretedXOffset, self.imageView.center.y);
            }else if (self.imageView.frame.origin.x >0){
                self.imageView.frame = CGRectMake(0, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
            }else if (self.imageView.frame.origin.x < self.frame.size.width - self.imageView.frame.size.width){
                self.imageView.frame = CGRectMake(self.frame.size.width - self.imageView.frame.size.width, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
            }
            
        } completion:nil];
    }];
}

-(void)stopAnimation{

    [[HBGravity sharedGravity] stop];
}

@end
