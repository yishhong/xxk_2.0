//
//  UIView+Mold.h
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KFontSize [UIFont systemFontOfSize:[self fontSize]]

@interface UIView (Mold)

//@property (nonatomic, assign) CGFloat fontSize;
- (instancetype)initWithDetails:(NSDictionary *)details;

+ (UIView *)getViewType:(NSString *)typeStr withDetails:(NSDictionary *)details;

- (void)setViews;

- (CGFloat)fontSize;

//取消
- (void)cancel;

//确定
- (void)confirm:(id)object;

@end
