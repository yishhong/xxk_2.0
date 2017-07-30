//
//  VPTravelTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActiveModel.h"
#import "UIImageView+VPWebImage.h"
#import "NSMutableAttributedString+AttributedString.h"

@implementation VPTravelTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cityNameLabel.textColor =[UIColor VPTitleColor];
//    self.priceLabel.textColor =[UIColor VPRedColor];
    self.typeLabel.textColor =[UIColor navigationTintColor];
    self.peopleNumLabel.textColor =[UIColor navigationTintColor];
    self.travelTypeLabel.textColor =[UIColor navigationTintColor];
    self.timeLabel.textColor =[UIColor VPDetailColor];
    
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPActiveModel * activeModel =cellModel.dataSource;
    [self.travelImageView xx_setImageWithURLStr:activeModel.image placeholder:[UIImage imageNamed:@"vp_topic_Image"]];
    self.cityNameLabel.text =activeModel.name;
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
//    attributedString=[attributedString attributedString:[NSString stringWithFormat:@"￥%@",activeModel.costs]];
//    self.priceLabel.attributedText =attributedString;
    self.priceLabel.text = activeModel.costs;
    self.peopleNumLabel.text = [NSString stringWithFormat:@"%@人已报名",activeModel.registrationCount];
    self.typeLabel.text =activeModel.keyword;
    if (activeModel.state==0) {
        self.travelTypeLabel.text =@"正在报名";
    }else if(activeModel.state==1){
        self.travelTypeLabel.text =@"报名已满";
    }else if(activeModel.state==2){
      self.travelTypeLabel.text =@"报名结束";
    }
    self.timeLabel.text =[NSString stringWithFormat:@"时间:%@至%@",activeModel.activeBeginTime,activeModel.activeDateTime];
}


@end
