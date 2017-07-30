//
//  HGTagView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HGTagView.h"
#import "NSString+Others.h"
#import "UIView+Frame.h"
#import "UIColor+HUE.h"

@implementation HGTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}

-(void)setTags:(NSArray *)tags{

    UIFont *tagFont = [UIFont systemFontOfSize:14];
    CGFloat tagX = 0.0;
    // tag
    for (int i=0; i<tags.count; i++) {
        CGSize tagSize = [tags[i] sizeWithFont:tagFont byHeight:self.height-6.0];
        CGFloat tagWidth = tagSize.width+6;
        
        CGFloat tagY = 0;
        
        CGRect tagRect = CGRectMake(tagX, tagY, tagWidth, tagSize.height);
        
        UIImageView *roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
        roundImageView.layer.cornerRadius = 1;
        roundImageView.backgroundColor = [UIColor blackColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:tagRect];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor controllerBackgroundColor];
        label.text = tags[i];
        label.layer.borderColor =[UIColor controllerBackgroundColor].CGColor;
        label.layer.borderWidth =1.0f;
        label.layer.cornerRadius=2.0f;
        label.font =[UIFont systemFontOfSize:12];
        [self addSubview:label];
        tagX += (tagWidth+8);
        
        roundImageView.center = CGPointMake(4, CGRectGetMidY(label.bounds));
    }
}

@end
