//
//  VPRoomFacilitiesTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#define dtScreenWidth  ([UIScreen mainScreen].bounds.size.width)


#import "VPRoomFacilitiesTableViewCell.h"
#import "VPFacilityCollectionView.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import <Masonry.h>


@interface VPRoomFacilitiesTableViewCell ()

@property(strong, nonatomic) VPFacilityCollectionView * facilityCollectionView;

@end

@implementation VPRoomFacilitiesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.facilityCollectionView = [[VPFacilityCollectionView alloc] init];
    [self addSubview:self.facilityCollectionView];
    [self.facilityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
        make.leading.mas_equalTo(self.contentView.mas_leading);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSArray *facilityArray =cellModel.dataSource;
    [self.facilityCollectionView focusImageItemsArray:facilityArray count:@(4)];
}



@end
