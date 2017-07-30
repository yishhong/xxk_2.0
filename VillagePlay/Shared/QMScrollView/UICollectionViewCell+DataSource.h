//
//  UICollectionViewCell+DataSource.h
//  scrollView
//
//  Created by Apricot on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (DataSource)
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
