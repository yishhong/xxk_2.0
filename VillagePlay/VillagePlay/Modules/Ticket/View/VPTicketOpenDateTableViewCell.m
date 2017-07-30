//
//  VPTicketOpenDateTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOpenDateTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPTicketListModel.h"

@implementation VPTicketOpenDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.openDateLabel.textColor =[UIColor VPContentColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    VPTicketListModel * ticketListModel =cellInfo[@"name"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beginDate = [formatter dateFromString:ticketListModel.actBeginDate];
    NSDate *endDate = [formatter dateFromString:ticketListModel.actEndDate];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *billBeginDate= [formatter stringFromDate:beginDate];
    NSString *billEndDate = [formatter stringFromDate:endDate];
    self.openDateLabel.text =[NSString stringWithFormat:@"%@至%@",billBeginDate,billEndDate];
    self.iconImageView.image =[UIImage imageNamed:cellInfo[@"image"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
