//
//  UIViewController+Empty.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIViewController+Empty.h"
#import <objc/runtime.h>

#define KShowViewType "showViewType"
#define KTextStr "K_TextStr"
#define KImageStr "K_ImageStr"

//static NSString *textStr = @"";
//static NSString *imageStr = @"";

@interface UIViewController ()
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, copy) NSString *imageStr;
@end

@implementation UIViewController (Empty)

- (void)setTextStr:(NSString *)textStr{
    objc_setAssociatedObject(self, KTextStr, textStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)textStr{
    return objc_getAssociatedObject(self, KTextStr);
}

- (void)setImageStr:(NSString *)imageStr{
    objc_setAssociatedObject(self, KImageStr, imageStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)imageStr{
    return objc_getAssociatedObject(self, KImageStr);
}

- (void)setShowViewType:(NSNumber *)showViewType{
    objc_setAssociatedObject(self, KShowViewType, showViewType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)isShowViewType:(NSInteger)code message:(NSString *)message{
    self.showViewType = @(code);
    switch (code) {
        case 0:{
            self.textStr = message;
            self.imageStr = @"";
        }break;
        case 1:{
            if(message.length>0){
                self.textStr = message;
            }else{
                self.textStr = @"这里什么都没有哦";
            }
            self.imageStr = @"NotData_icon";
        }break;
        case 200:
        case 400:{
            self.textStr = message;
            self.imageStr = @"";
        }break;
        case 1024:{
            self.textStr = message;
            self.imageStr = @"NotNetWork_icon";
        }break;
        default:{
        }break;
    }
    
}

- (NSNumber *)showViewType{
    return objc_getAssociatedObject(self, KShowViewType);
}

#pragma mark - DZNEmptyDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *image = [UIImage imageNamed:self.imageStr];
    return image;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.5;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
//标题文本，详细描述，富文本样式

//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *text = @"( ¯ □ ¯ ) ";
////    NSString *text = @"~~o(>_<)o ~~";
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:25.0f],
//                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
//    
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.textStr;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//按钮文本或者背景样式
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    
//    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
//}
//
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    return [UIImage imageNamed:@"button_image"];
//}
//空白页的背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    NSLog(@"按钮？");
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"空白页点击事件");
}
//设置偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -64.0/2.0;
}
//组件间的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 20.0f;
}
//是否显示空数据
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}
//交互的权限
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
//请求滚动权限
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
//请求图片加载的动画效果
- (BOOL)emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return YES;
}
////点击数据View的事件
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
//{
//    // Do something
//}
////点击图片事件
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
//{
//    // Do something
//}
@end
