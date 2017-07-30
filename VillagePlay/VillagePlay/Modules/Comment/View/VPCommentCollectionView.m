//
//  VPCommentCollectionView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentCollectionView.h"
#import "VPCommentCollectionViewCell.h"
#import "UIImageView+VPWebImage.h"

@interface VPCommentCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong, nonatomic)NSArray * dataSource;

@end

@implementation VPCommentCollectionView

-(void)awakeFromNib{
    [super awakeFromNib];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =CGSizeMake(90, 74);
    flowLayout.minimumLineSpacing=5;
    flowLayout.minimumInteritemSpacing=5;
    flowLayout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 5);
    flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    collectionView.showsVerticalScrollIndicator=NO;
    collectionView.showsHorizontalScrollIndicator=NO;
    collectionView.backgroundColor =[UIColor whiteColor];
    collectionView.delegate=self;
    collectionView.dataSource =self;
    [self addSubview:collectionView];
    self.collectionView =collectionView;

    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPCommentCollectionViewCell class])];
}

- (void)commentArray:(NSArray *)commentArray{
    self.dataSource =commentArray;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * urlString =self.dataSource[indexPath.row];
    VPCommentCollectionViewCell * commentCollectionViewCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VPCommentCollectionViewCell class]) forIndexPath:indexPath];
    [commentCollectionViewCell.travelImageView xx_setImageWithURLStr:urlString placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
    return commentCollectionViewCell;
}
@end
