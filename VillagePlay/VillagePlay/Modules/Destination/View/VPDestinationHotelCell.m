//
//  VPDestinationHotelCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationHotelCell.h"
#import "QMImageViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@interface VPDestinationHotelCell ()<QMScrollViewDelegate>

@end

@implementation VPDestinationHotelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.hotelScrollView layerUIWithCellClass:[QMImageViewCell class]];
    self.hotelScrollView.delegate = self;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    [self.hotelScrollView configDataSource:cellModel.dataSource];
}

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    [self xx_cellClickAtView:self.hotelScrollView data:indexPath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
