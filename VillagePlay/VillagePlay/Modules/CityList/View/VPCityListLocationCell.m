//
//  VPCityListLocationCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCityListLocationCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPOpenCityInfoModel.h"
#import "UIColor+HUE.h"
#import "VPLocationManager.h"

@interface VPCityListLocationCell ()

@property (nonatomic, strong) NSMutableDictionary *locationDict;

@end

@implementation VPCityListLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.refreshButton addTarget:self action:@selector(refreshLocation) forControlEvents:UIControlEventTouchUpInside];
}
- (void)refreshLocation{
    if([self.locationDict[@"status"] integerValue]== -1){
        self.locationDict[@"status"] = @(-2);//获取位置中
        self.lb_title.text = @"定位中...";
        [[VPLocationManager sharedManager] startLocation:^(NSError *error, CLLocationCoordinate2D locationCoordinate) {
            
            if(!error){
                //当前位置
                self.locationDict[@"cityName"] = [VPLocationManager sharedManager].geoLocation.addressDetail.city;
                
                if([[VPLocationManager sharedManager] isOpenCityReturnBoolWithType:[self.locationDict[@"type"] integerValue]]){
                    self.locationDict[@"status"] = @1;//已开通
                    self.locationDict[@"cityModel"] = [VPLocationManager sharedManager].cityModel;
                    self.lb_title.text = self.locationDict[@"cityName"];

                }else{
                    self.locationDict[@"status"] = @2;//未开通
                    self.lb_title.text = @"当前城市未开通";
                }
            }else{
                //未获取定位
                self.locationDict[@"status"] = @0;
                self.lb_title.text = @"当前无法获取地理位置";

            }
        }];
    }else{
        switch ([self.locationDict[@"status"] integerValue]) {
            case 0:{
                self.lb_title.text = @"当前无法获取地理位置";
            }break;
            case 1:{
                self.lb_title.text = self.locationDict[@"cityName"];
            }break;
            case 2:{
                self.lb_title.text = @"当前城市未开通";
            }break;
            default:
                break;
        }
        
    }
}
- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.locationDict = cellModel.dataSource;
//    self.lb_title.text = @"定位中...";
    self.lb_title.textColor = [UIColor blackTextColor];
    self.refreshButton.hidden = YES;
    [self refreshLocation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
