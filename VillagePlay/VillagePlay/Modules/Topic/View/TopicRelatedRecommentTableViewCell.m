//
//  TopicRelatedRecommentTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#define dtScreenWidth  [UIScreen mainScreen].bounds.size.width

#import "TopicRelatedRecommentTableViewCell.h"
#import <objc/runtime.h>
#import "UIImageView+VPWebImage.h"
#import "UIView+Frame.h"
#import "UIColor+HUE.h"
#import "TopicRelatedRecommentCollectionViewCell.h"
#import "UITableViewCell+DataSource.h"

@interface TopicRelatedRecommentTableViewCell()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong, nonatomic)UIView * recommentView;

@property(strong,nonatomic)UICollectionView *collectionView;

@property(strong,nonatomic)NSArray *imageItems;

@property(strong, nonatomic)UIPageControl * pageControl;

@end

@implementation TopicRelatedRecommentTableViewCell

- (void)xx_configCellWithEntity:(id)entity{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.imageItems =[NSArray alloc];
        NSArray * imageArr =@[@"http://pic9.nipic.com/20100924/2531170_005125723538_2.jpg",@"http://img.taopic.com/uploads/allimg/110104/292-11010410531619.jpg",@"http://pic9.nipic.com/20100924/2531170_005125723538_2.jpg"];
        self.imageItems =[imageArr copy];
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    UIView *recommentView =[[UIView alloc]initWithFrame:CGRectMake(20, 0, dtScreenWidth-40, 170)];
    recommentView.backgroundColor =[UIColor colorWithRed:0.9172 green:0.9406 blue:0.9653 alpha:1.0];
    [self addSubview:recommentView];
    self.recommentView =recommentView;
    
    UILabel * recommendNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(16, 14, self.recommentView.width, 13)];
    recommendNameLabel.text =@"活动推荐";
    recommendNameLabel.font =[UIFont systemFontOfSize:13];
    recommendNameLabel.textColor =[UIColor VPContentColor];
    [self.recommentView addSubview:recommendNameLabel];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =CGSizeMake(dtScreenWidth-40, 110);
    flowLayout.minimumLineSpacing =0;
    flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, recommendNameLabel.bottom+13, dtScreenWidth-40, 110) collectionViewLayout:flowLayout];
    collectionView.backgroundColor =[UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.delegate =self;
    collectionView.dataSource =self;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.showsVerticalScrollIndicator=NO;
    collectionView.showsHorizontalScrollIndicator =NO;
    [self.recommentView addSubview:collectionView];
    self.collectionView =collectionView;
    
    UIPageControl * pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-(self.imageItems.count*(8+10)-10))/2, self.collectionView.bottom+5, 8, 8)];
    pageControl.numberOfPages =self.imageItems.count;
    pageControl.currentPage=0;
    pageControl.pageIndicatorTintColor =[UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor =[UIColor navigationTintColor];
    [self addSubview:pageControl];
    self.pageControl =pageControl;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicRelatedRecommentCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([TopicRelatedRecommentCollectionViewCell class])];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopicRelatedRecommentCollectionViewCell *relatedRecommentCollectionViewCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TopicRelatedRecommentCollectionViewCell class]) forIndexPath:indexPath];
    [relatedRecommentCollectionViewCell.recommendImageView xx_setImageWithURLStr:self.imageItems[indexPath.row] placeholder:[UIImage imageNamed:@"travel"]];
    return relatedRecommentCollectionViewCell;
}

#pragma mark -UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger current =self.collectionView.contentOffset.x/(dtScreenWidth-40);
    NSLog(@"%ld",current);
    NSLog(@"%lf",self.collectionView.contentOffset.x);
    self.pageControl.currentPage =current;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}


@end
