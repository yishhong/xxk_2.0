//
//  QMScrollView.h
//  scrollView
//
//  Created by Apricot on 16/11/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QMScrollViewDelegate <NSObject>

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface QMScrollView : UIView

/**
 *  布局UI
 *
 *  @param identifier Cell
 */
- (void)layerUIWithCellClass:(nullable Class)cellClass;

/**
 *  配置数据源
 *
 *  @param dataSoure 数据源
 */
- (void)configDataSource:(nullable NSArray *)dataSoure;

@property (nonatomic, weak) id<QMScrollViewDelegate> delegate;

@end
