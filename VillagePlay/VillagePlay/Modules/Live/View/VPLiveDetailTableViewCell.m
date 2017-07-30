//
//  VPLiveDetailTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveDetailTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPLiveInfoModel.h"
#import "NSString+NumberRound.h"

@implementation VPLiveDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPContentColor];
    self.commentLabel.textColor =[UIColor VPDetailColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellMcell =entity;
    VPLiveInfoModel *liveInfoModel =cellMcell.dataSource;
    self.nameLabel.text =liveInfoModel.title;
    
    self.commentLabel.text =[NSString stringWithFormat:@"%@次浏览",[[@(liveInfoModel.viewNum) stringValue] numericalConversion]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
