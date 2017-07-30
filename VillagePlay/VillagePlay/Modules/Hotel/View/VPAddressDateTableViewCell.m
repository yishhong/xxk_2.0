//
//  VPAddressDateTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAddressDateTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelDetailModel.h"
#import "NSDate+Extension.h"
#import "QMCalendarFunction.h"

@interface VPAddressDateTableViewCell ()

@property (strong, nonatomic)QMCalendarFunction *calendarFunction;

@end

@implementation VPAddressDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.calendarFunction =[[QMCalendarFunction alloc]init];
    self.checkDateLabel.textColor =[UIColor VPContentColor];
    self.outDateLabel.textColor =[UIColor VPContentColor];
    [self.checkButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
    [self.outButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];

    
    self.checkView.userInteractionEnabled =YES;
    self.outView.userInteractionEnabled =YES;
    self.checkDateLabel.userInteractionEnabled=YES;
    self.outDateLabel.userInteractionEnabled =YES;
    self.checkWeekLabel.userInteractionEnabled=YES;
    self.outWeekLabel.userInteractionEnabled=YES;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    NSDictionary * deteInfo =cellModel.dataSource;
    NSString *checkWeekString =[self.calendarFunction weekDay:deteInfo[@"todayDate"]];
    NSString *outWeekString =[self.calendarFunction weekDay:deteInfo[@"tomorrowDate"]];
    
    NSString * checkWeekDate =[NSString stringWithFormat:@"%@日",[deteInfo[@"todayTime"] stringByReplacingOccurrencesOfString:@"-" withString:@"月"]];
    
    NSString * outWeekDate =[NSString stringWithFormat:@"%@日",[deteInfo[@"tomorrowTime"] stringByReplacingOccurrencesOfString:@"-" withString:@"月"]];
    self.checkDateLabel.text =checkWeekDate;
    self.outDateLabel.text =outWeekDate;
    
    self.checkWeekLabel.text =checkWeekString;
    self.outWeekLabel.text =outWeekString;
    
}

- (IBAction)checkAction:(id)sender {
}

- (IBAction)outAction:(id)sender {
}
@end
