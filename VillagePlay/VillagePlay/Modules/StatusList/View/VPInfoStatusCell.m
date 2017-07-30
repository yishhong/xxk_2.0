//
//  VPInfoStatusCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPInfoStatusCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelRefundDetailModel.h"
#import "UIColor+HUE.h"
#import "VPTravelRefundDetailModel.h"

@implementation VPInfoStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    VPTravelRefundDetailModel * travelRefundDetailModel =cellModel.dataSource;
    self.lb_title.text =travelRefundDetailModel.activitieName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beginDate = [formatter dateFromString:travelRefundDetailModel.applyDate];
    NSDate *endDate = [formatter dateFromString:travelRefundDetailModel.joinDate];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *billBeginDate= [formatter stringFromDate:beginDate];
    NSString *billEndDate = [formatter stringFromDate:endDate];
    
    self.lb_date.text =[NSString stringWithFormat:@"使用时间:%@至%@",billBeginDate,billEndDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
