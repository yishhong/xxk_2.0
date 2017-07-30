//
//  QMCalendarDayCell.h
//  Calendar
//
//  Created by Apricot on 16/7/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMCalendarDayCell : UICollectionViewCell
/**
 *  用于显示日期
 */
@property (nonatomic, strong) UILabel *dayLabel;

/**
 *  用于显示副标题
 */
@property (nonatomic, strong) UILabel *otherLabel;



/**
 该时间是否可选

 @param isOption BOOL YES 可选 NO为不可选
 */
- (void)isOption:(BOOL)isOption;

/**
 配置数据

 @param entity data
 */
- (void)xx_configCellWithEntity:(id)entity;


@end
