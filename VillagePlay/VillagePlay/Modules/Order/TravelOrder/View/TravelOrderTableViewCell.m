//
//  TravelOrderTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelOrderTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "UIImageView+VPWebImage.h"

@implementation TravelOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =[UIColor controllerBackgroundColor];
    self.timeLabel.textColor =[UIColor VPContentColor];
    self.tickeNumbertLabel.textColor =[UIColor VPContentColor];
    self.priceLabel.textColor =[UIColor VPTitleColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    NSDictionary * cellInfo =cellModel.dataSource;
    [self.orderImageView xx_setImageWithURLStr:cellInfo[@"homePicture"] placeholder:[UIImage imageNamed:@"vp_comment_Image"]];
    if ([cellInfo[@"billType"] isEqualToString:@"1"]) {
        self.timeLabel.text =[NSString stringWithFormat:@"%@至%@",cellInfo[@"billBeginDate"],cellInfo[@"billBeginDate"]];
    }else{
      
        if ([cellInfo[@"orderNum"] isEqualToString:@""]) {
            self.timeLabel.text =[NSString stringWithFormat:@"%@",cellInfo[@"joinDate"]];
            self.tickeNumbertLabel.text= cellInfo[@"roomType"];
        }else{
            self.timeLabel.text =[NSString stringWithFormat:@"%@出行",cellInfo[@"joinDate"]];
            self.tickeNumbertLabel.text =[NSString stringWithFormat:@"共%@张票",cellInfo[@"orderNum"]];
        }
    }
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",[cellInfo[@"price"] floatValue]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
