//
//  HotelCancelTypeTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelCancelTypeTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelOrderDetailModel.h"

@implementation HotelCancelTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelTypeLabel.textColor =[UIColor navigationTintColor];
    self.cancelContentLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary *cellInfo =cellModel.dataSource;
    if ([cellInfo[@"ruleid"] integerValue]==1) {
        self.cancelTypeLabel.text=@"限时取消";
    }else{
    
        self.cancelTypeLabel.text =@"不可取消";
    }
    self.cancelContentLabel.text =cellInfo[@"ruleString"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
