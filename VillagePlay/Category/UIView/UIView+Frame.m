//
//  UIView+Frame.m
//  DTUtils
//  
//  Created by zhaojh on 16/7/14.
//  Copyright (c) 2014年 zjh. All rights reserved.
//

#import "UIView+Frame.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (Frame)

#pragma mark - Set size and origin
- (CGPoint)origin
{
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}

- (CGSize)size
{
	return self.frame.size;
}

- (void)setSize:(CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

#pragma mark - 中心位置
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark - Frame的位置
- (CGPoint)bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint)topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}

- (CGPoint)offset
{
    CGPoint	point = CGPointZero;
	UIView *view = self;
    
	while ( view )
	{
		point.x += view.x;
		point.y += view.y;
		view = view.superview;
        
//        if (dtIsKindOf(view, UIScrollView)) {
//            point.x -= ((UIScrollView *)view).contentOffset.x;
//            point.y -= ((UIScrollView *)view).contentOffset.y;
//        }
	}
	
	return point;
    
//    return [self convertPoint:CGPointZero toView:nil];
}

- (void)setOffset:(CGPoint)offset
{
    UIView * view = self;
	if ( nil == view )
		return;
    
	CGPoint point = offset;
    
	while ( view )
	{
		point.x += view.superview.frame.origin.x;
		point.y += view.superview.frame.origin.y;
        
		view = view.superview;
	}
    
    CGRect frame = self.frame;
	frame.origin = point;
	self.frame = frame;
}

- (CGPoint)offsetFromView:(UIView *)otherView {
    CGFloat x = 0.0f, y = 0.0f;
    for (UIView *view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

#pragma mark - Frame的四个值

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.left;
}

- (void)setX:(CGFloat)x
{
    self.left = x;
}

- (CGFloat)y
{
    return self.top;
}

- (void)setY:(CGFloat)y
{
    self.top = y;
}

#pragma mark - Move via offset
- (void)moveBy:(CGPoint)delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

#pragma mark - Scaling
- (void)scaleBy:(CGFloat)scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

#pragma mark - 按比例缩小,确保两个尺寸适合
- (void)fitInSize:(CGSize)aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}

// gridItem 的frame
- (CGRect)getFrameWithPerRowItemCount:(NSInteger)perRowItemCount
                    perColumItemCount:(NSInteger)perColumItemCount
                            itemWidth:(CGFloat)itemWidth
                           itemHeight:(NSInteger)itemHeight
                             paddingX:(CGFloat)paddingX
                             paddingY:(CGFloat)paddingY
                              atIndex:(NSInteger)index
                               onPage:(NSInteger)page {
    CGRect itemFrame = CGRectMake((index % perRowItemCount) * (itemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.bounds)), ((index / perRowItemCount) - perColumItemCount * page) * (itemHeight + paddingY) + paddingY, itemWidth, itemHeight);
    return itemFrame;
}

@end
