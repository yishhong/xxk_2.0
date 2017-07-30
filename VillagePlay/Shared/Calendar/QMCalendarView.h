//
//  QMCalendarView.h
//  Calendar
//
//  Created by Apricot on 16/7/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//  日历控件

#import <UIKit/UIKit.h>

@protocol QMCalendarViewDelegate <NSObject>

- (void)calendarSelectDay:(NSInteger)day withMonth:(NSInteger)month withyear:(NSInteger)year;

@end

@interface QMCalendarView : UIView
@property (nonatomic, weak) id<QMCalendarViewDelegate>delegate;
/**
 *
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray * dataArray;
/**
 *  值的字典（通过年月入获取）
 */
@property (nonatomic, strong) NSDictionary *valueDict;
/**
 *  布局界面
 */
- (void)setLayout;
/**
 *  更新数据
 */
- (void)reloadData;

@end
