//
//  VPPlayTitleCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayTitleCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPPlayDetailModel.h"

@implementation VPPlayTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_title.text = @"";
    self.image.image =nil;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *cellInfo = cellModel.dataSource;
    VPPlayDetailModel* playDetailModel = cellInfo[@"value"];
    self.lb_title.text = playDetailModel.title;
    NSString *imageStr = @"";
    if([playDetailModel.title isEqualToString:@"游玩攻略"]){
        imageStr = @"icon_tab_wf_play";
    }else if ([playDetailModel.title isEqualToString:@"交通攻略"]){
        imageStr = @"icon_tab_wf_traffic";
    }else if ([playDetailModel.title isEqualToString:@"门票攻略"]){
        imageStr = @"icon_tab_wf_ticket";
    }else if ([playDetailModel.title isEqualToString:@"餐饮攻略"]){
        imageStr = @"icon_tab_wf_restaurant";
    }else if ([playDetailModel.title isEqualToString:@"住宿攻略"]){
        imageStr = @"icon_tab_wf_hotel";
    }
    self.image.image = [UIImage imageNamed:imageStr];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
