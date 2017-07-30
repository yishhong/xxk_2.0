//
//  VPCommentCollectionView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPCommentCollectionView : UIView

@property (strong, nonatomic) UICollectionView *collectionView;

- (void)commentArray:(NSArray *)commentArray;

@end
