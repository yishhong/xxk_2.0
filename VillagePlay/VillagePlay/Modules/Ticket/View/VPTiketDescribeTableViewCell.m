//
//  VPTiketDescribeTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTiketDescribeTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPTopicDetailModel.h"

@implementation VPTiketDescribeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)xx_configCellWithEntity:(id)entity{

    
    XXCellModel * cellModel =entity;
    NSString *contText =cellModel.dataSource;
    NSString * htmlString =[NSString stringWithFormat:@"%@",contText];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
