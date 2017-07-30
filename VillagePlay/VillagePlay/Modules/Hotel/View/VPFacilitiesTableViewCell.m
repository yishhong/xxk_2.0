//
//  VPFacilitiesTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPFacilitiesTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPFacilityCollectionView.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import <Masonry.h>

@interface VPFacilitiesTableViewCell()

@property(strong, nonatomic)VPFacilityCollectionView * facilityCollectionView;

@end

@implementation VPFacilitiesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.moreButton setTitleColor:[UIColor navigationTintColor] forState:UIControlStateNormal];
    self.facilityCollectionView = [[VPFacilityCollectionView alloc] init];
    [self.moreBackgroundView addSubview:self.facilityCollectionView];
    [self.facilityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.moreBackgroundView.mas_trailing);
        make.leading.mas_equalTo(self.moreBackgroundView.mas_leading);
        make.top.mas_equalTo(self.moreBackgroundView).offset(0);
        make.bottom.mas_equalTo(self.moreBackgroundView.mas_bottom);
    }];

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSArray *facilityArray =cellModel.dataSource;
    [self.facilityCollectionView focusImageItemsArray:facilityArray count:@(4)];
}

- (IBAction)moreAction:(UIButton *)sender {
    
    sender.tag=20;
    [self xx_cellClickAtView:sender];
}


@end
