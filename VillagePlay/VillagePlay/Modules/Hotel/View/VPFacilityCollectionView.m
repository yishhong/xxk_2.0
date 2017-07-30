//
//  VPFacilityCollectionView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPFacilityCollectionView.h"
#import <objc/runtime.h>
#import "VPFacilitiesCollectionViewCell.h"
#import "UIView+Frame.h"
#import "VPFacilityListModel.h"
#import "UIImageView+VPWebImage.h"
#import <Masonry.h>


@interface VPFacilityCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView * collectionView;

@property (strong, nonatomic) NSArray * dataSource;

@property (assign, nonatomic) NSInteger count;

@end

@implementation VPFacilityCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSArray array];
        self.count =0;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection =UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        self.collectionView.userInteractionEnabled =NO;
        self.collectionView.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing);
            make.leading.mas_equalTo(self.mas_leading);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPFacilitiesCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPFacilitiesCollectionViewCell class])];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;

    }
    return self;
}


- (void)focusImageItemsArray:(NSArray *)items count:(NSNumber *)count{

    self.dataSource =[items mutableCopy];
    self.count = [count integerValue];
    [self.collectionView reloadData];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.width/self.count, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VPFacilityListModel *facilityListModel =self.dataSource[indexPath.row];
    VPFacilitiesCollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VPFacilitiesCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imageView xx_setImageWithURLStr:facilityListModel.iconUrl placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
    cell.nameLabel.text =facilityListModel.title;
    return cell;
}





@end
