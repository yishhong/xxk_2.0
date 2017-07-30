//
//  TsetTableViewCell.h
//  JSDropDownMenuDemo
//
//  Created by Apricot on 2016/12/5.
//  Copyright © 2016年 jsfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPSelectPriceCellDelegete <NSObject>

- (void)startPrice:(double)startPrice endPrice:(double)endPrice;

@end

@interface VPSelectPriceCell : UITableViewCell
@property (nonatomic, weak) id<VPSelectPriceCellDelegete>delegate;
@end
