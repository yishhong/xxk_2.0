//
//  VPHotelNameTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelNameTableViewCell.h"
#import "UIColor+HUE.h"
#import "AMRatingControl.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelDetailModel.h"

@interface VPHotelNameTableViewCell ()

@property(strong, nonatomic)AMRatingControl *rateCtl;

@end

@implementation VPHotelNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPTitleColor];
    self.commentNumber.textColor =[UIColor VPDetailColor];
    AMRatingControl * rateCtl=[[AMRatingControl alloc]initWithLocation:CGPointMake(0, 0) emptyImage:[UIImage imageNamed:@"icon_ tour_star_gray"] solidImage:[UIImage imageNamed:@"icon_ tour_star_blue"] andMaxRating:5];
    rateCtl.frame =CGRectMake(0, 0, 23*5, 20);
    rateCtl.userInteractionEnabled = NO;
    rateCtl.rating = 2;
    [self.starView addSubview:rateCtl];
    self.rateCtl =rateCtl;
#warning 评论数暂时隐藏
    self.commentNumber.hidden = YES;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel *cellModel =entity;
    VPHotelDetailModel *hotelDetailModel=cellModel.dataSource;
    self.nameLabel.text =hotelDetailModel.title;
    self.rateCtl.rating =hotelDetailModel.taxRate;
    self.commentNumber.text =@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
