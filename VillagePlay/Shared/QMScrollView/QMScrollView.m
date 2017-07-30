//
//  QMScrollView.m
//  scrollView
//
//  Created by Apricot on 16/11/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMScrollView.h"
#import "QMPageView.h"
#import "UICollectionViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import <Masonry.h>

@interface QMScrollView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray * dataSource;

@end

@implementation QMScrollView

- (void)layerUIWithCellClass:(Class)cellClass{
    self.dataSource = [NSMutableArray array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:layout];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:@"identifier"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-30, CGRectGetWidth(self.frame), 30)];
    self.pageControl.numberOfPages = 0;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:0.4];
    self.pageControl.currentPageIndicatorTintColor = [UIColor navigationTintColor];
    [self addSubview:self.pageControl];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).offset(0);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.mas_bottom).offset(-15);
    }];

}

- (void)configDataSource:(NSArray *)dataSoure{
    self.dataSource = [dataSoure mutableCopy];
    self.pageControl.numberOfPages = [self.dataSource count];
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = YES;
    if([dataSoure count]>1){
        [self.dataSource insertObject:[dataSoure lastObject] atIndex:0];
        [self.dataSource addObject:dataSoure[0]];
        self.pageControl.hidden = NO;
    }
    [self.collectionView reloadData];
    if([dataSoure count]>1){
        [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0) animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/CGRectGetWidth(self.collectionView.frame);
    self.pageControl.currentPage = index-1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x<=0){
        [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.frame)*([self.dataSource count]-2), 0) animated:NO];
    }else if(scrollView.contentOffset.x>=CGRectGetWidth(self.collectionView.frame)*([self.dataSource count]-1)){
        [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.frame), 0) animated:NO];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell xx_configCellWithEntity:self.dataSource[indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(selectItemAtIndexPath:)]){
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        if([self.dataSource count]>1){
            if(indexPath.row ==0){
                selectIndexPath = [NSIndexPath indexPathForRow:[self.dataSource count]-3 inSection:indexPath.section];
            }else if(indexPath.row == [self.dataSource count]-1){
                selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
            }else{
                selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
            }
        }
        [self.delegate selectItemAtIndexPath:selectIndexPath];
    }
}

@end
