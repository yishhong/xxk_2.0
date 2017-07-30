//
//  VPTiketDateUsedTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTiketDateUsedTableViewCell.h"
#import "VPTietDateUsedCollectionViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "VPTietMoreDateCollectionViewCell.h"
#import "XXCellModel.h"
#import "VPTicketSubitInformationModel.h"
#import "VPCalendarOneController.h"

@interface VPTiketDateUsedTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong, nonatomic)NSMutableArray *dateSource;

@property(assign, nonatomic) NSInteger selectIndex;

@property (strong, nonatomic) NSMutableDictionary *cellInfo;

@property (assign, nonatomic) BOOL isSelestDate;

@end

@implementation VPTiketDateUsedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectIndex =0;
    self.dateSource =[[NSMutableArray alloc]init];
    self.collectionView.backgroundColor =[UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection =UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing =5;
    flowLayout.minimumInteritemSpacing =5;
    self.collectionView.collectionViewLayout =flowLayout;
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTietDateUsedCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPTietDateUsedCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTietMoreDateCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPTietMoreDateCollectionViewCell class])];
}

- (void)xx_configCellWithEntity:(id)entity{
    self.isSelestDate = NO;
    XXCellModel * cellModel = entity;
    self.cellInfo = cellModel.dataSource;
    self.dateSource = self.cellInfo[@"lstActivityDate"];
    
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dateSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * cellInfo =self.dateSource[indexPath.row];
    if (indexPath.row==2) {
        VPTietMoreDateCollectionViewCell *tietMoreDateCollectionViewCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VPTietMoreDateCollectionViewCell class]) forIndexPath:indexPath];
        NSDictionary *dayInfo = self.dateSource[indexPath.row];

        tietMoreDateCollectionViewCell.timeLabel.text = cellInfo[@"today"];
        if(!self.isSelestDate){
            self.isSelestDate = YES;
            tietMoreDateCollectionViewCell.tiketSelectImageView.image =[UIImage imageNamed:@"moreDateBlue"];
            tietMoreDateCollectionViewCell.timeLabel.textColor = [UIColor navigationTintColor];
            tietMoreDateCollectionViewCell.timeLabel.text = [NSString stringWithFormat:@"%@\n%@",dayInfo[@"today"],self.cellInfo[@"selectTime"]];
        }else{
            tietMoreDateCollectionViewCell.tiketSelectImageView.image =[UIImage imageNamed:@"moreDateWhite"];
            tietMoreDateCollectionViewCell.timeLabel.textColor =[UIColor VPTitleColor];
//            selectCollectionViewCell.todayLabel.text = @"";
        }
        return tietMoreDateCollectionViewCell;
    }else{
        VPTietDateUsedCollectionViewCell *selectCollectionViewCell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VPTietDateUsedCollectionViewCell class]) forIndexPath:indexPath];
        selectCollectionViewCell.todayLabel.text =cellInfo[@"today"];
        selectCollectionViewCell.timeLabel.text =cellInfo[@"time"];
        NSDictionary *dayInfo = self.dateSource[indexPath.row];
        if([self.cellInfo[@"selectDate"] isEqualToString:dayInfo[@"date"]]&&(!self.isSelestDate)){
            self.isSelestDate = YES;
            selectCollectionViewCell.tiketSelectSelectImage.image =[UIImage imageNamed:@"tiketDateBlue"];
            selectCollectionViewCell.timeLabel.textColor =[UIColor navigationTintColor];
            selectCollectionViewCell.todayLabel.textColor =[UIColor navigationTintColor];
        }else{
            selectCollectionViewCell.tiketSelectSelectImage.image =[UIImage imageNamed:@"tiketDateWhite"];
            selectCollectionViewCell.timeLabel.textColor =[UIColor VPTitleColor];
            selectCollectionViewCell.todayLabel.textColor =[UIColor VPTitleColor];
        }
        return selectCollectionViewCell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return CGSizeMake(90, 56);
    }
    return CGSizeMake(59, 56);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 0);
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row==3){
////        self.cellInfo[@"select"] = @(indexPath.row);
////        self.cellInfo[@"selectDate"] =
//        NSLog(@"cheshi");
//    }else{
////        self.cellInfo[@"select"] = @(indexPath.row);
////        self.cellInfo[@"selectDate"] = self.dateSource[indexPath.row][@"date"];
//    }
    
    [self xx_cellClickAtView:self.contentView data:@(indexPath.row)];

    
//    NSDictionary * cellInfo =self.dateSource[indexPath.row];
//    VPTicketSubitInformationModel *ticketSubitInformationModel =self.cellInfo[@"subit"];
//    ticketSubitInformationModel.joinDate = cellInfo[@"date"];
////    self.selectIndex =indexPath.row;
//    [self.collectionView reloadData];
}

@end
