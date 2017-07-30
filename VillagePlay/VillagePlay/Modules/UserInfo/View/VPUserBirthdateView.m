//
//  VPUserBirthdateView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserBirthdateView.h"
#import "CNPPopupController.h"
#import "UIColor+HUE.h"

@interface VPUserBirthdateView ()<CNPPopupControllerDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) SelectBirthdateBlock selectBirthdateBlock;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) NSString *selectBirthdate;

@end

@implementation VPUserBirthdateView

+ (instancetype)instantiation{
    VPUserBirthdateView *view = [[VPUserBirthdateView alloc] init];
    view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 280);
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datePicker = [[UIDatePicker alloc] init];
        [self addSubview:self.datePicker];
        [self.datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
        NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePicker.locale = locale;
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self.datePicker setMaximumDate:[NSDate date]];//设置最大日期值
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *minDate = [self.dateFormatter dateFromString:@"1900-01-01"];
        [self.datePicker setMinimumDate:minDate];
        self.selectBirthdate = @"";
    }
    return self;
}

- (void)showViewWithNowSelectDate:(NSString *)nowSelectDate Block:(SelectBirthdateBlock)selectBirthdateBlock{
    if(selectBirthdateBlock){
        if(self.selectBirthdateBlock){
            self.selectBirthdateBlock = nil;
        }
        self.selectBirthdateBlock = selectBirthdateBlock;
    }
    if(nowSelectDate.length>1){
        self.selectBirthdate = nowSelectDate;
        [self.datePicker setDate:[self.dateFormatter dateFromString:nowSelectDate] animated:YES];
    }
    
    self.lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    [self addSubview:self.lb_title];
    self.lb_title.font = [UIFont systemFontOfSize:16];
    //    lb_title.backgroundColor = [UIColor navigationTintColor];
    //    lb_title.textColor = [UIColor whiteColor];
    self.lb_title.text = @"出生日期";
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lb_title.frame)-0.5, CGRectGetWidth(self.lb_title.frame), 0.5)];
    lineView.backgroundColor = [UIColor septalLineColor];
    [self addSubview:lineView];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = [UIColor navigationTintColor];
    confirmButton.layer.cornerRadius = 3;
    [confirmButton addTarget:self action:@selector(tapSelectBirthdate) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.frame = CGRectMake(CGRectGetWidth(self.frame)-54, 3, 50, CGRectGetHeight(self.lb_title.frame)-6);
    [self addSubview:confirmButton];
    
    self.datePicker.frame = CGRectMake(0, CGRectGetMaxY(self.lb_title.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.lb_title.frame));

    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self]];
    CNPPopupTheme *theme = [CNPPopupTheme defaultTheme];
    theme.popupContentInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    theme.shouldDismissOnBackgroundTouch = NO;
    self.popupController.theme = theme;
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.delegate = self;
    
    [self.popupController presentPopupControllerAnimated:YES];
}

- (void)popupControllerDidDismiss:(nonnull CNPPopupController *)controller{
    [self removeFromSuperview];
}

- (void)tapSelectBirthdate{
    self.selectBirthdateBlock(self.selectBirthdate);
    [self.popupController dismissPopupControllerAnimated:YES];
}


- (void)datePickerChange:(UIDatePicker *)paramPicker{
    NSDate *selected = paramPicker.date;
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    self.selectBirthdate = [self.dateFormatter stringFromDate:selected];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
