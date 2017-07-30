//
//  QMCalendarView.m
//  Calendar
//
//  Created by Apricot on 16/7/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMCalendarView.h"
#import "QMCalendarFlowLayout.h"
#import "QMCalendarDayCell.h"
#import "QMCalendarHeadView.h"


#define KCellIdentifier @"QMCalendarDayCell"
#define KHeadIdentifier @"QMCalendarHeadView"
@interface QMCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView * weekView;
//@property (nonatomic, strong)

@end

@implementation QMCalendarView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
/**
 *  布局界面
 */
- (void)setLayout{    
    self.weekView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 42)];
    self.weekView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    [self addSubview:self.weekView];
    
    [self setSubWeekData];
    
    QMCalendarFlowLayout *layout = [[QMCalendarFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.weekView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.weekView.frame)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[QMCalendarHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeadIdentifier];
    [self.collectionView registerClass:[QMCalendarDayCell class] forCellWithReuseIdentifier:KCellIdentifier];
}

- (void)reloadData{
    [self.collectionView reloadData];
}

/**
 设置周的时间
 */
- (void)setSubWeekData{
    NSArray *weekData = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat width = CGRectGetWidth(self.weekView.frame)/[weekData count];
    CGFloat height= CGRectGetHeight(self.weekView.frame);
    for (int i =0; i<weekData.count; i++) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        weekLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:30.0/255.0 blue:48.0/255.0 alpha:1.0];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.font = [UIFont systemFontOfSize:14];
        weekLabel.text = weekData[i];
        [self.weekView addSubview:weekLabel];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    QMCalendarHeadView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                          withReuseIdentifier:KHeadIdentifier
                                                                 forIndexPath:indexPath];
        NSDictionary *monthDict = [self.dataArray objectAtIndex:indexPath.section];
        
        [reusableview title:[NSString stringWithFormat:@"%ld年%ld月",[monthDict[@"year"] integerValue],[monthDict[@"month"] integerValue]]];
    }
    return reusableview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QMCalendarDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier forIndexPath:indexPath];
    NSDictionary *monthDict = [self.dataArray objectAtIndex:indexPath.section];
    NSArray *days = monthDict[@"days"];
    //天的字典
    NSMutableDictionary *dayDict = [days[indexPath.row] mutableCopy];
    dayDict[@"year"] = monthDict[@"year"];
    dayDict[@"month"] = monthDict[@"month"];
    dayDict[@"valueData"] = self.valueDict;
    
    [cell xx_configCellWithEntity:dayDict];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *monthDict = [self.dataArray objectAtIndex:section];
    return [monthDict[@"days"] count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *monthDict = [self.dataArray objectAtIndex:indexPath.section];
    NSArray *days = monthDict[@"days"];
    NSString *day = days[indexPath.row][@"day"];
    BOOL isOption = [days[indexPath.row][@"isOption"] boolValue];
    if(!isOption){
        return;
    }
    if([self.delegate respondsToSelector:@selector(calendarSelectDay:withMonth:withyear:)]){
        [self.delegate calendarSelectDay:[day intValue] withMonth:[monthDict[@"month"] integerValue] withyear:[monthDict[@"year"] integerValue]];
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = CGRectGetWidth(self.frame)/7.0;
    return CGSizeMake(width, 59);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



@end
