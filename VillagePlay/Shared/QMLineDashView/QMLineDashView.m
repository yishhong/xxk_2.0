//
//  QMLineDashView.m
//  CNPPopupControllerExample
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Carson Perrotti. All rights reserved.
//

#import "QMLineDashView.h"

@implementation QMLineDashView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {4,1};
    CGContextSetLineDash(context, 0, lengths,2);
    //开始绘制点
    CGContextMoveToPoint(context, 6, 6);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)-6,6.0);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)-6.0,CGRectGetHeight(rect)-6.0);
    CGContextAddLineToPoint(context, 6.0,CGRectGetHeight(rect)-6.0);
    CGContextAddLineToPoint(context, 6.0,6.0);
    //连接上面的坐标点
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 15,CGRectGetHeight(rect)-28.0);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)- 15,CGRectGetHeight(rect)-28.0);
    CGContextStrokePath(context);
    
}


@end
