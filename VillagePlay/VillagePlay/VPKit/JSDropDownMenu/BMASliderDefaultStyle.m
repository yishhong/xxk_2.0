/*
 The MIT License (MIT)
 
 Copyright (c) 2015-present Badoo Trading Limited.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "BMASliderDefaultStyle.h"
#import "UIColor+HUE.h"
@implementation BMASliderDefaultStyle

//- (UIImage *)unselectedLineImage {
//    return [UIImage imageNamed:@"range_slider_unselected_background" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
//}
- (UIImage *)unselectedLineImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(3., 2.), NO, [[UIScreen mainScreen] scale]);
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0., 0., 3., 2.)];
    [[UIColor navigationTintColor] setFill];
    [rectanglePath fill];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [thumbnail resizableImageWithCapInsets:UIEdgeInsetsMake(0., 1., 0., 1.) resizingMode:UIImageResizingModeStretch];
}

//- (UIImage *)selectedLineImage {
//    return [UIImage imageNamed:@"range_slider_selected_background" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
//}

- (UIImage *)selectedLineImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(3., 2.), NO, [[UIScreen mainScreen] scale]);
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0., 0., 3., 2.)];
//    [UIColor.redColor setFill];
    [[UIColor navigationTintColor] setFill];
    [rectanglePath fill];
    
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [thumbnail resizableImageWithCapInsets:UIEdgeInsetsMake(0., 1., 0., 1.) resizingMode:UIImageResizingModeStretch];
}


- (UIImage *)handlerImage {
    return [UIImage imageNamed:@"icon_price" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

@end
