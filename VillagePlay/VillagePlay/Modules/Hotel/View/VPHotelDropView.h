//
//  VPHotelDropView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPHotelDropViewDelegate <NSObject>

/**
 tag菜单

 @param startPrice 开始价格
 @param endPrice 结束价格
 */
- (void)hotelStartPrice:(double)hotelStartPrice hotelEndPrice:(double)hotelEndPrice;

/**
 排序
 @param orderByType 0默认排序，1价格由低到高，2距离排序
 */
- (void)orderByType:(NSInteger)orderByType;

@end

@interface VPHotelDropView : UIView

- (void)configLeftData:(NSArray *)leftArray rightData:(NSArray *)rightArray;

@property(strong, nonatomic)id<VPHotelDropViewDelegate>delegate;

@end
