//
//  VPNavigationRightBarView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPNavigationRightBarViewDelegate <NSObject>

-(void)selectIndex:(NSInteger)index;

@end

@interface VPNavigationRightBarView : UIView

@property(strong, nonatomic)id<VPNavigationRightBarViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;

-(void)imageSource:(NSArray*)imageSource;

@end
