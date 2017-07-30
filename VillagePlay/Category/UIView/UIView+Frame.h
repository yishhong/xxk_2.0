//
//  UIView+Frame.h
//  DTUtils
//  返回UIView及其子类的位置和尺寸。
//  Created by zhaojh on 16/7/14.
//  Copyright (c) 2014年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Frame)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat left;  // x
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat top;  // y
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;   //w
@property (nonatomic) CGFloat height;  //h

@property (nonatomic) CGFloat	centerX;
@property (nonatomic) CGFloat	centerY;

@property (nonatomic, readonly) CGPoint bottomLeft;
@property (nonatomic, readonly) CGPoint bottomRight;
@property (nonatomic, readonly) CGPoint topRight;

//当前视图相对于最底端视图的坐标  --- 偏移值
@property (nonatomic) CGPoint offset;

- (CGPoint)offsetFromView:(UIView *)otherView;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;


/**
 *  通过目标的参数，获取一个grid布局
 *
 *  @param perRowItemCount   每行有多少列
 *  @param perColumItemCount 每列有多少行
 *  @param itemWidth         gridItem的宽度
 *  @param itemHeight        gridItem的高度
 *  @param paddingX          gridItem之间的X轴间隔
 *  @param paddingY          gridItem之间的Y轴间隔
 *  @param index             某个gridItem所在的index序号
 *  @param page              某个gridItem所在的页码
 *
 *  @return 返回一个已经处理好的gridItem frame
 */
- (CGRect)getFrameWithPerRowItemCount:(NSInteger)perRowItemCount
                    perColumItemCount:(NSInteger)perColumItemCount
                            itemWidth:(CGFloat)itemWidth
                           itemHeight:(NSInteger)itemHeight
                             paddingX:(CGFloat)paddingX
                             paddingY:(CGFloat)paddingY
                              atIndex:(NSInteger)index
                               onPage:(NSInteger)page;


@end
