//
//  VPAddressTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAddressTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPFacilitiesCollectionViewCell.h"
#import "VPFacilityCollectionView.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelDetailModel.h"
#import "QMMapFuntion.h"
#import "VPLocationManager.h"


@interface VPAddressTableViewCell ()

@end

@implementation VPAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressLabel.textColor =[UIColor VPContentColor];
    
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    CLLocationCoordinate2D location = [QMMapFuntion transformCoordinate:cellInfo[@"location"]];
    
    if ([cellInfo[@"hide"] isEqualToString:@"1"]) {
        
        [[VPLocationManager sharedManager] reverseGeoCode:location block:^(BOOL isSuccee, BMKReverseGeoCodeResult *result) {
            if(isSuccee){
                self.addressLabel.text = result.address;
            }
        }];
    }else{
    
        self.addressLabel.text =cellInfo[@"location"];
    }
}

@end
