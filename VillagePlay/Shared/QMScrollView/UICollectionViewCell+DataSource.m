//
//  UICollectionViewCell+DataSource.m
//  scrollView
//
//  Created by Apricot on 16/11/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UICollectionViewCell+DataSource.h"

@implementation UICollectionViewCell (DataSource)
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)xx_configCellWithEntity:(id)entity{
    
}
@end
