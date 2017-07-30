//
//  VPVillageDropView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPVillageDropViewDelegate <NSObject>

/**
 tag刷新

 @param tagName tag名
 */
- (void)villageTagName:(NSString *)tagName;

/**
 排序
 @param sortType 排序 0 热门 1 按距离 2 默认
 */
-(void)sortType:(NSInteger)sortType;

@end

@interface VPVillageDropView : UIView

- (void)configLeftData:(NSArray *)leftArray rightData:(NSArray *)rightArray;

@property (strong, nonatomic) id<VPVillageDropViewDelegate>delegate;

@end
