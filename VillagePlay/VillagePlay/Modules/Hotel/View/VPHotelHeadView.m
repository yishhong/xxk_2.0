//
//  VPHotelHeadView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#define dtScreenWidth  [UIScreen mainScreen].bounds.size.width

#import "VPHotelHeadView.h"
#import <objc/runtime.h>
#import "VPHotelHeadCollectionViewCell.h"
#import "UIImageView+VPWebImage.h"
#import "UIView+Frame.h"
#import <Masonry.h>
#import "AMRatingControl.h"
#import "UIColor+HUE.h"
#import "VPImgListModel.h"
#import "VPVillageImagesModel.h"

@interface VPHotelHeadView ()

@property (assign, nonatomic)NSInteger commentNum;

@property (strong, nonatomic)NSMutableArray * tags;

@end

@implementation VPHotelHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.leftCount=1;
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize =CGSizeMake(dtScreenWidth, self.height);
        flowLayout.minimumLineSpacing =0;
        flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        UICollectionView * collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, self.height) collectionViewLayout:flowLayout];
        collectionView.backgroundColor =[UIColor clearColor];
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator=NO;
        collectionView.showsHorizontalScrollIndicator =NO;
        [self addSubview:collectionView];
        self.collectionView =collectionView;
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelHeadCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPHotelHeadCollectionViewCell class])];
        collectionView.delegate =self;
        collectionView.dataSource =self;
    }
    return self;
}

-(void)focusImageItemsArray:(NSArray *)items isRight:(BOOL)isRight{

    self.imageItems =[items copy];
    self.isRight =isRight;
    [self setUp];
    [self.collectionView reloadData];
}

-(void)setUp{
    
    self.rightCount = self.imageItems.count;
    UILabel * numberLanel;
    if (self.isRight) {
        numberLanel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-(34+12),CGRectGetHeight(self.frame)-(17.0+9), 34, 17)];

    }else{
    numberLanel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-(34+12))/2.0,CGRectGetHeight(self.frame)-17.0-9, 34, 17)];
    }

    numberLanel.backgroundColor =[UIColor colorWithWhite:0 alpha:0.5];
    numberLanel.textAlignment = NSTextAlignmentCenter;
    numberLanel.textColor = [UIColor whiteColor];
    numberLanel.layer.masksToBounds = YES;
    numberLanel.layer.cornerRadius = 8;
    numberLanel.font = [UIFont systemFontOfSize:10];
    if(self.rightCount <1){
        numberLanel.text = @"";
        numberLanel.hidden = YES;
    }else{
        numberLanel.hidden = NO;
        numberLanel.text =[NSString stringWithFormat:@"%ld/"@"%ld",(long)self.leftCount,(long)self.rightCount];
    }
    [self addSubview:numberLanel];
    self.numberLabel =numberLanel;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VPHotelHeadCollectionViewCell *hotelHeadCollectionViewCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VPHotelHeadCollectionViewCell class]) forIndexPath:indexPath];

    if (self.isRight) {
        VPVillageImagesModel * villageImagesModel =self.imageItems[indexPath.row];
        hotelHeadCollectionViewCell.headImageView.contentMode =UIViewContentModeScaleAspectFill;
        [hotelHeadCollectionViewCell.headImageView xx_setImageWithURLStr:villageImagesModel.bigimageUrl placeholder:[UIImage imageNamed:@"vp_topicDetail_Image"]];

    }else{

        VPImgListModel *  imgListModel =self.imageItems[indexPath.row];
        hotelHeadCollectionViewCell.headImageView.contentMode =UIViewContentModeScaleAspectFill;
        [hotelHeadCollectionViewCell.headImageView xx_setImageWithURLStr:imgListModel.originalImg placeholder:[UIImage imageNamed:@"vp_topicDetail_Image"]];
    }
    return hotelHeadCollectionViewCell;
}

#pragma mark -UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(VPHotelHeadViewSelectImage:imageList:)]) {
        
        [self.delegate VPHotelHeadViewSelectImage:indexPath.row imageList:self.imageItems];
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    self.leftCount =self.collectionView.contentOffset.x/dtScreenWidth+1;
    if (self.leftCount >= self.rightCount) {
        
        if (self.tappedBlock) {
            
            self.tappedBlock();
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.leftCount =(int)self.collectionView.contentOffset.x/dtScreenWidth+1;
    self.numberLabel.text =[NSString stringWithFormat:@"%ld/"@"%ld",(long)self.leftCount,(long)self.rightCount];
}

@end
