//
//  UIView+Mold.m
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIView+Mold.h"
#import <objc/runtime.h>

//#define KAssociatedFontSize "AssociatedFontSize"

@implementation UIView (Mold)


- (CGFloat)fontSize{
    return [UIScreen mainScreen].bounds.size.width/([UIScreen mainScreen].bounds.size.width/16);
}

- (instancetype)initWithDetails:(NSDictionary *)details{
    
    return self;
}
+ (UIView *)getViewType:(NSString *)typeStr withDetails:(NSDictionary *)details{
    if(typeStr.length>0){
        Class viewClass = NSClassFromString(typeStr);
        if (viewClass != nil) {
            UIView *view = [[viewClass alloc] initWithDetails:details];
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
            view.backgroundColor = [UIColor whiteColor];
            return view;
        }
    }
    return nil;
}
- (void)setViews{

}

- (void)cancel{

}

- (void)confirm:(id)object{

}

@end
