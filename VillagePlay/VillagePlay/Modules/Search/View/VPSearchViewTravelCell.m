//
//  VPSearchViewTravelCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewTravelCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPSearchModel.h"
#import "UIImageView+VPWebImage.h"
#import "UIColor+HUE.h"

@implementation VPSearchViewTravelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_title.text = @"";
    self.lb_subTitle.text = @"";
    self.lb_price.text = @"";
    self.lb_price.textColor = [UIColor VPRedColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPSearchModel *searchModel = cellModel.dataSource;
    self.lb_title.text = searchModel.title;

    self.lb_price.text = searchModel.price;
    NSString *stateStr = @"";
    switch (searchModel.state) {
        case 0:{
            stateStr = @"正在报名";
        }break;
        case 1:{
            stateStr = @"报名已满";
        }break;
        case 2:{
            stateStr = @"报名结束";
        }break;
        default:
            break;
    }
//    self.lb_subTitle.text = [NSString stringWithFormat:@"%@  %@  %zd人已报名",searchModel.actKeyword,stateStr,searchModel.personNum];
    self.lb_subTitle.text = [NSString stringWithFormat:@"%@  %zd人已报名",stateStr,searchModel.personNum];

    [self.traveImage  xx_setImageWithURLStr:searchModel.img placeholder:[UIImage imageNamed:@""]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
