//
//  UITableViewCell+DataSource.h
//  HotelBusiness
//
//  Created by Apricot on 16/7/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DataSource)
/**
 *  返回nib
 *
 *  @return 返回nib
 */
+ (UINib *)nib;


/**
 *  根据实体,设置cell样式
 *
 *  @param entity 实体
 */
- (void)xx_configCellWithEntity:(id)entity;

@end

@interface UITableViewCell (XXCellEvent)


/**
 cell的坐标

 @return 返回 NSIndexPath
 */
- (NSIndexPath *)xx_indexPath;

/**
 *  cell 点击调用该方法，将会回调给 tableView 的 delegate 里面，执行：tableView:clickCell:atView: 方法
 *
 *  @param view View对象
 */
- (void)xx_cellClickAtView:(UIView *)view;

- (void)xx_cellClickAtView:(UIView *)view data:(id)data;

/**
 *  获取 cell 所在 tableView
 *
 *  @return tableView
 */
- (UITableView *)xx_tableView;

@end

@interface NSObject(XXCellEvent)

/**
*  cell 点击如果调用了 xx_cellClickAtView: 方法，tableView 的delegate 里面，会调用该方法
*
*  @param tableView <#tableView description#>
*  @param clickCell <#clickCell description#>
*  @param indexPath <#indexPath description#>
*  @param view      <#view description#>
*/
- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view;

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view data:(id)data;

@end

