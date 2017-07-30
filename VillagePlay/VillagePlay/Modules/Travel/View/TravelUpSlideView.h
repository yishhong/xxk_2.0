//
//  TravelUpSlideView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TravelUpSlideViewDelegate <NSObject>

- (void)selectIndex:(NSInteger)selectIndex;

@end

@interface TravelUpSlideView : UIView

@property (strong, nonatomic)id<TravelUpSlideViewDelegate>delegate;

- (void)showAnimation:(BOOL)animation;
- (void)hideAnimation:(BOOL)animation;

@end
