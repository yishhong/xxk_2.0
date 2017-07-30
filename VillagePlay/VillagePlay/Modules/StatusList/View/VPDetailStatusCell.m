//
//  VPDetailStatusCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDetailStatusCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "UIColor+HUE.h"

@implementation VPDetailStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailLabel.text = @"";
    self.detailLabel.text = @"";
    self.dateLabel.text =@"";
    self.contentView.backgroundColor =[UIColor controllerBackgroundColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    NSString * timeString =[NSString stringWithFormat:@"%@",cellInfo[@"time"]];
    self.titleLabel.text =cellInfo[@"title"];
    self.dateLabel.text =cellInfo[@"time"];
    if (timeString.length>0) {
        self.detailLabel.text =cellInfo[@"description"];
        self.selectImage.image =[UIImage imageNamed:@"vp_order_statusList_selectStatus"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
