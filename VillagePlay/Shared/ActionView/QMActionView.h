//
//  QMActionview.h
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    QMActionViewTypeWarn = 0,
    QMActionViewTypeSelector,
    QMActionViewTypeText,
} QMActionViewType;

@interface QMActionView : UIView

+ (void)showActionViewType:(QMActionViewType)actionViewType withDetails:(NSDictionary *)details confirm:(void(^)(id object))confirm cancel:(void(^)())cancel;

@end
