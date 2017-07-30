//
//  VPTraveCouponTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTraveCouponTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPCouponModel.h"
#import "VPHotelSubmitModel.h"

@interface VPTraveCouponTableViewCell ()
@property (nonatomic, strong) XXCellModel * cellModel;
@end

@implementation VPTraveCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.couponLabel.textColor =[UIColor VPContentColor];
    self.numberUsableLabel.textColor=[UIColor whiteColor];
    self.numberUsableLabel.backgroundColor =[UIColor navigationTintColor];
    self.usableLabel.textColor =[UIColor VPContentColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updata) name:@"updateConponInfo" object:nil];
}

- (void)updata{
    self.usableLabel.text = self.cellModel.dataSource;
}

- (void)xx_configCellWithEntity:(id)entity{

    self.cellModel =entity;
    
    if([self.cellModel.dataSource isKindOfClass:[VPHotelSubmitModel class]]){
        //民宿的优惠券
        VPHotelSubmitModel *hotelSubmitModel = self.cellModel.dataSource;
        if(hotelSubmitModel.preferentialAmount>0){
            self.usableLabel.text = [NSString stringWithFormat:@"已优惠%.2f元",hotelSubmitModel.preferentialAmount];
        }else{
            self.usableLabel.text =  @"未使用";
        }
    }else if ([self.cellModel.dataSource isKindOfClass:[NSString class]]){
        self.usableLabel.text = self.cellModel.dataSource;
    }
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
