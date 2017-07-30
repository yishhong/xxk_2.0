//
//  VPHotelHeadView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPVillageDetailModel.h"

typedef void(^VPHotelHeaderViewBlock)();

@protocol VPHotelHeadViewDelegate <NSObject>

- (void)VPHotelHeadViewSelectImage:(NSInteger)selectImage imageList:(NSArray *)imageList;

@end

@interface VPHotelHeadView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic)UICollectionView *collectionView;

@property(strong,nonatomic)UIImageView *imageView;

@property(strong,nonatomic)UILabel * numberLabel;

@property(assign,nonatomic)NSInteger leftCount;

@property(assign,nonatomic)NSInteger rightCount;

@property(strong,nonatomic)NSArray *imageItems;

@property(assign, nonatomic)BOOL isRight;

@property(strong,nonatomic)VPHotelHeaderViewBlock tappedBlock;

@property(strong, nonatomic)id<VPHotelHeadViewDelegate>delegate;

-(void)focusImageItemsArray:(NSArray *)items isRight:(BOOL)isRight;

@end
