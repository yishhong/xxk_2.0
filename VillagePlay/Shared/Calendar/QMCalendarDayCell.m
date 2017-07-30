//
//  QMCalendarDayCell.m
//  Calendar
//
//  Created by Apricot on 16/7/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMCalendarDayCell.h"

#define selectColor [UIColor colorWithRed:73.0/255.0 green:198.0/255.0 blue:216.0/255.0 alpha:1.0]

#define selectCentreColor [UIColor colorWithRed:208.0/255.0 green:243.0/255.0 blue:248.0/255.0 alpha:1.0]


@implementation QMCalendarDayCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

        [self initView];
//        self.contentView.backgroundColor = [UIColor colorWithRed:0.9843 green:0.6627 blue:0.4667 alpha:1.0];
//        self.contentView.layer.borderWidth = 0.5;
//        self.contentView.layer.borderColor = [UIColor colorWithRed:0.8824 green:0.5412 blue:0.3451 alpha:1.0].CGColor;
    }
    return self;
}
- (void)initView{
    self.dayLabel = [self createLabelViewWithFont:19
                                   textAlingnment:NSTextAlignmentCenter];
    self.otherLabel = [self createLabelViewWithFont:12
                                     textAlingnment:NSTextAlignmentCenter];
    
    self.dayLabel.text = @"";
    self.otherLabel.text = @"入住";
    self.dayLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1.0];
    self.otherLabel.textColor = [UIColor whiteColor];
    
    //布局
    NSLayoutConstraint *dayXLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.dayLabel
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.contentView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:CGRectGetWidth(self.frame)/2.0];
    [self.contentView addConstraint:dayXLayoutConstraint];
    
    NSLayoutConstraint *dayYLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.dayLabel
                                                                            attribute:NSLayoutAttributeCenterY
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.contentView
                                                                            attribute:NSLayoutAttributeCenterY
                                                                           multiplier:1
                                                                             constant:CGRectGetHeight(self.frame)/2.0];
    [self.contentView addConstraint:dayYLayoutConstraint];
    
//   NSLayoutConstraint *otherTopLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.otherLabel
//                                                                               attribute:NSLayoutAttributeTop
//                                                                               relatedBy:NSLayoutRelationEqual
//                                                                                  toItem:self.dayLabel
//                                                                               attribute:NSLayoutAttributeBottom
//                                                                              multiplier:1
//                                                                                constant:0];
//    [self.contentView addConstraint:otherTopLayoutConstraint];
    
   NSLayoutConstraint *otherYLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.otherLabel
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.dayLabel
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1
                                                                              constant:CGRectGetWidth(self.dayLabel.frame)/2.0];
    [self.contentView addConstraint:otherYLayoutConstraint];
    
    NSLayoutConstraint *otherBottomLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.otherLabel
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.contentView
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:2
                                                                                    constant:CGRectGetHeight(self.frame)];
    [self.contentView addConstraint:otherBottomLayoutConstraint];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self addSubview:lineView];

    
}
- (UILabel *)createLabelViewWithFont:(CGFloat)size textAlingnment:(NSTextAlignment)textAlingnment{
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:size];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = textAlingnment;
    [self.contentView addSubview:label];
    return label;
}

- (void)isOption:(BOOL)isOption{
    if(isOption){
        self.dayLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1.0];
    }else{
        self.dayLabel.textColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
        self.backgroundColor = [UIColor whiteColor];
        self.otherLabel.text = @"";
    }
}

- (void)xx_configCellWithEntity:(id)entity{
    NSDictionary *dayDict = entity;
    //天数
    NSString *day = dayDict[@"day"];
    //是否可选
    BOOL isOption = [dayDict[@"isOption"] boolValue];
    NSString *key = [NSString stringWithFormat:@"%zd%02zd%02zd",[dayDict[@"year"] integerValue],[dayDict[@"month"] integerValue],[day integerValue]];
    NSInteger nowDate = [key integerValue];
    self.dayLabel.text = day;
    
    //首先还原cell所有的文本状态
    [self option];
    
    if(!isOption){
        [self noOption];
    }else{
        NSDictionary * valueData = dayDict[@"valueData"];
        if([[valueData allKeys] containsObject:@"selectDate"]){
            NSInteger selectDate = [valueData[@"selectDate"] integerValue];
            if(nowDate == selectDate){
                [self selectStatus];
            }
        }else{
            NSInteger beginDate = [valueData[@"beginDate"] integerValue];
            NSInteger endDate = [valueData[@"endDate"] integerValue];
            if(nowDate >beginDate && nowDate < endDate){
                [self selectCentreStatus];
            }else if(nowDate == beginDate){
                [self selectStatus];
                self.otherLabel.text = @"入住";
            }else if (nowDate == endDate){
                [self selectStatus];
                self.otherLabel.text = @"离店";
            }
        }
    }
}



/*
 不可选的颜色
 默认的颜色
 当前选中的颜色
 中间的日期颜色
 */

/**
 可选的状态
 */
- (void)option{
    self.dayLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1.0];
    self.otherLabel.text = @"";
    self.backgroundColor = [UIColor whiteColor];
}

/**
 不可选的状态
 */
- (void)noOption{
    self.dayLabel.textColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
    self.backgroundColor = [UIColor whiteColor];
    self.otherLabel.text = @"";
}

/**
 选中的状态
 */
- (void)selectStatus{
    self.dayLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = selectColor;
    self.otherLabel.textColor = self.dayLabel.textColor;
}

/**
 选中的中间cell
 */
- (void)selectCentreStatus{
    self.dayLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:30.0/255.0 blue:48.0/255.0 alpha:1.0];
    self.backgroundColor = selectCentreColor;
    self.otherLabel.text = @"";
}


@end
