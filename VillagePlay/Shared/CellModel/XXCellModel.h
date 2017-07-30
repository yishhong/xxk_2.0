//
//  XXCellModel.h
//  VillagePlay
//
//  Created by Apricot on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 用来自定义cell在某块内容处于第几个
 */
typedef enum : NSUInteger {
    CellLocationBegin = 0,
    CellLocationCentre,
    CellLocationEnd,
} CellLocation;

@interface XXCellModel : NSObject
//高度 数据 cell 名称 单个或者多个点击的事件以及处理对应的事

/**
 *  标题
 */
@property(nonatomic, strong)NSString * title;

/**
 *  副标题
 */
@property(nonatomic,copy)NSString * subTitle;

/**
 *  cell的标识
 */
@property (nonatomic, copy) NSString * identifier;

/**
 *  高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  数据源
 */
@property (nonatomic, strong) id dataSource;

/**
 *  处理事件
 */
@property (nonatomic, assign) SEL action;

/**
 *  键盘类型
 */
@property (nonatomic, assign)UIKeyboardType keyboardType;

/**
 *  cell的location （目前主要用来处理分割线的显示，或许可以做其他的用途）
 */
@property (nonatomic, assign) CellLocation location;


+(instancetype)instantiationWithIdentifier:(NSString *)identifier height:(CGFloat)height dataSource:(id)dataSource action:(SEL)action;
@end
