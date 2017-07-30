//
//  VPDateSelectView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/2/15.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "VPDateSelectView.h"
#import "VPDateSelectCollectionViewCell.h"
#import "VPActivityDateModel.h"
#import "UIColor+HUE.h"
#import <Masonry.h>

#define dtScreenWidth [UIScreen mainScreen].bounds.size.width

@interface VPDateSelectView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic)UICollectionView *collectionView;

@property(strong, nonatomic)NSMutableArray * dateSource;

@end

@implementation VPDateSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dateSource=[[NSMutableArray alloc]init];
        self.currentIndex =-1;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection =UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing);
            make.leading.mas_equalTo(self.mas_leading);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPDateSelectCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPDateSelectCollectionViewCell class])];
        self.collectionView.delegate=self;
        self.collectionView.dataSource =self;
    }
    return self;
}

- (void)activeDetailModel:(NSArray *)activeDetailModel{

    self.dateSource =[activeDetailModel mutableCopy];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate* currentDate = [NSDate date];
    NSString * stringDate = [dateFormatter stringFromDate:currentDate];
    currentDate =[dateFormatter dateFromString:stringDate];
    NSTimeInterval currentTimerInterval = [currentDate timeIntervalSince1970];
    
    for (NSInteger index=0; index<self.dateSource.count; index++) {
        VPActivityDateModel *dateModel = self.dateSource[index];
        NSDate * date = [dateFormatter dateFromString:dateModel.actDate];
        NSTimeInterval timeInterval = date.timeIntervalSince1970;
        
        if (dateModel.tickets!=0 && currentTimerInterval<= timeInterval) {
            self.currentIndex = index;
            if ([self.delegate respondsToSelector:@selector(selectViewDateString:tickets:)]) {
                [self.delegate selectViewDateString:dateModel.actDate tickets:dateModel.tickets];
            }
            break;
        }
    }
    [self.collectionView reloadData];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dateSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VPActivityDateModel *dateModel =self.dateSource[indexPath.row];
    VPDateSelectCollectionViewCell *selectCollectionViewCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VPDateSelectCollectionViewCell class]) forIndexPath:indexPath];
    selectCollectionViewCell.dateLabel.text =dateModel.actDate;
    selectCollectionViewCell.remainingLabel.text =[NSString stringWithFormat:@"余票%ld",(long)dateModel.tickets];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate* currentDate = [NSDate date];
    NSString * stringDate = [dateFormatter stringFromDate:currentDate];
    currentDate =[dateFormatter dateFromString:stringDate];
    NSTimeInterval currentTimerInterval = [currentDate timeIntervalSince1970];
    
    NSDate * date = [dateFormatter dateFromString:dateModel.actDate];
    NSTimeInterval timeInterval = date.timeIntervalSince1970;
    if (dateModel.tickets>0) {
        selectCollectionViewCell.userInteractionEnabled=YES;
        if (indexPath.row ==self.currentIndex) {
            
            selectCollectionViewCell.selectImageView.image =[UIImage imageNamed:@"tab_tour_frame_blue"];
            selectCollectionViewCell.dateLabel.textColor =[UIColor navigationTintColor];
            selectCollectionViewCell.remainingLabel.textColor=[UIColor navigationTintColor];
            
        }else{
            selectCollectionViewCell.selectImageView.image =[UIImage imageNamed:@"tab_tour_frame_white"];
            if (timeInterval<currentTimerInterval){
                selectCollectionViewCell.backgroundColor=[UIColor whiteColor];
                selectCollectionViewCell.dateLabel.textColor =[UIColor VPDetailColor];
                selectCollectionViewCell.remainingLabel.textColor=[UIColor VPDetailColor];
            }else{
                selectCollectionViewCell.backgroundColor=[UIColor whiteColor];
                selectCollectionViewCell.dateLabel.textColor =[UIColor VPTitleColor];
                selectCollectionViewCell.remainingLabel.textColor=[UIColor VPTitleColor];
            }

        }
        
    }else{

        if (currentTimerInterval<timeInterval) {
            
            selectCollectionViewCell.remainingLabel.text =@"已过期";
            selectCollectionViewCell.dateLabel.textColor =[UIColor VPDetailColor];
            selectCollectionViewCell.remainingLabel.textColor =[UIColor VPDetailColor];
        }
        selectCollectionViewCell.selectImageView.image =[UIImage imageNamed:@"tab_tour_frame_white"];
        selectCollectionViewCell.dateLabel.textColor =[UIColor VPDetailColor];
        selectCollectionViewCell.remainingLabel.textColor=[UIColor VPDetailColor];
        selectCollectionViewCell.remainingLabel.text =[NSString stringWithFormat:@"余票%ld",(long)dateModel.tickets];
        selectCollectionViewCell.userInteractionEnabled=NO;
    }
    return selectCollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((dtScreenWidth-40)/3, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    VPActivityDateModel *dateModel =self.dateSource[indexPath.row];
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate * date =[dateFormatter dateFromString:dateModel.actDate];
    NSTimeInterval timeInterval =date.timeIntervalSince1970;
    
    NSDate* currentDate = [NSDate date];
    NSDateFormatter * matter =[[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy-MM-dd"];
    [matter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString * stringDate =[dateFormatter stringFromDate:currentDate];
    currentDate =[dateFormatter dateFromString:stringDate];
    NSTimeInterval currentTimerInterval=[currentDate timeIntervalSince1970];
    if (timeInterval<currentTimerInterval) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前活动日期已过期" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    self.currentIndex =indexPath.row;
    if ([self.delegate respondsToSelector:@selector(selectViewDateString:tickets:)]) {
        [self.delegate selectViewDateString:dateModel.actDate tickets:dateModel.tickets];
    }
    [self.collectionView reloadData];
}



@end
