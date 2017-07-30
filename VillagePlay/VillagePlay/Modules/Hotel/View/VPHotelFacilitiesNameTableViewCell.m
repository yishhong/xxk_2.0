//
//  VPHotelFacilitiesNameTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelFacilitiesNameTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import <Masonry.h>
#import "VPFacilityCollectionView.h"



@interface VPHotelFacilitiesNameTableViewCell ()

@property(strong, nonatomic) VPFacilityCollectionView * facilityCollectionView;


@end

@implementation VPHotelFacilitiesNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.facilityCollectionView = [[VPFacilityCollectionView alloc] init];
    [self addSubview:self.facilityCollectionView];
    [self.facilityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
        make.leading.mas_equalTo(self.contentView.mas_leading);
        make.top.mas_equalTo(self.lb_explain.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel *cellModel =entity;
    NSArray *facilityArray =cellModel.dataSource;
    [self.facilityCollectionView focusImageItemsArray:facilityArray count:@(5)];
}

@end
