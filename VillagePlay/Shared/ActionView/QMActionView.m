//
//  QMActionview.m
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMActionView.h"
#import "AppDelegate.h"
#import "UIView+Mold.h"

typedef void(^ConfirmBlock)(id object);
typedef void(^CancelBlock)();

@interface QMActionView ()
//需要一个显示的类型
//内容的View
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) QMActionViewType actionViewType;
@property (nonatomic, strong) NSDictionary *details;
@property (nonatomic, copy) ConfirmBlock confirmBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;
@end

@implementation QMActionView

- (instancetype)initWithViewType:(QMActionViewType)actionViewType withDetails:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
        self.actionViewType = actionViewType;
        self.details = details;
        [self.contentView setViews];

    }
    return self;
}

- (UIView *)contentView{
    if(!_contentView){
        
        CGFloat width = 0;
        CGFloat height = 0;
        NSString *viewTypeClassStr = @"";
        switch (self.actionViewType) {
            case QMActionViewTypeWarn:{
                width = CGRectGetWidth(self.frame)/7.00000*6.00000;
                height = CGRectGetHeight(self.frame)/10.00000*2.00000;
                viewTypeClassStr = @"QMWarnActionView";
            }break;
            case QMActionViewTypeSelector:{
                width = CGRectGetWidth(self.frame)/7.00000*6.00000;
                height = CGRectGetHeight(self.frame)/7.00000*1.00000+162;
                viewTypeClassStr = @"QMSelectorActionView";

            }break;
            case QMActionViewTypeText:{
                //输入框模式的 QMTextActionView
                width = CGRectGetWidth(self.frame)/7.00000*6.00000;
                height = CGRectGetHeight(self.frame)/8.00000*2.00000;
                viewTypeClassStr = @"QMTextActionView";
            }break;
            default:
                break;
        }
        _contentView = [UIView getViewType:viewTypeClassStr
                               withDetails:self.details];
        _contentView.frame= CGRectMake((CGRectGetWidth(self.frame)-width)/2.00000, (CGRectGetHeight(self.frame)-height)/2.00000, width,height);
        [self addSubview:self.contentView];
    }
    return _contentView;
}
+ (void)showActionViewType:(QMActionViewType)actionViewType withDetails:(NSDictionary *)details confirm:(void(^)(id object))confirm cancel:(void(^)())cancel{
    QMActionView *avtionView = [[QMActionView alloc] initWithViewType:actionViewType withDetails:details];
    if (confirm) {
        avtionView.confirmBlock = confirm;
    }
    if(cancel){
        avtionView.cancelBlock = cancel;
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:avtionView];
}


//一般处理取消的操作
-(void)cancel{
    self.cancelBlock();
    [self removeFromSuperview];
}

//一般处理确定的操作
-(void)confirm:(id)object{
    self.confirmBlock(object);
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if([touch.view isEqual:self]){
        [self removeFromSuperview];
    }
}
@end
