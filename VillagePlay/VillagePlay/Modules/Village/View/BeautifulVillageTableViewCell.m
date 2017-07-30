//
//  BeautifulVillageTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "BeautifulVillageTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPVillageModel.h"
#import "UIImageView+VPWebImage.h"
#import "VPTagModel.h"

@implementation BeautifulVillageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.villageImageView.layer.masksToBounds =YES;
    self.belowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPVillageModel * villageModel =cellModel.dataSource;
    [self.villageImageView xx_setImageWithURLStr:villageModel.image placeholder:[UIImage imageNamed:@"vp_topicDetail_Image"]];
    self.villageNameLabel.text =villageModel.name;
    NSString * typeString=@"";
    for (int i=0; i<villageModel.tags.count; i++) {
        VPTagModel * tagModel =villageModel.tags[i];
        if (tagModel.tagName) {
            NSString * addString =[NSString stringWithFormat:@"%@·",tagModel.tagName];
            typeString =[typeString stringByAppendingString:addString];
        }
    }
    if (typeString.length>0&&![typeString isEqualToString:@""]&&typeString) {
        NSRange range =NSMakeRange(0, typeString.length-1);
        NSString *string =[typeString substringWithRange:range];
        self.villageTypeLabel.text =string;
    }
    if([villageModel.distance isEqualToString:@"未知"]){
        self.distanceLabel.text = villageModel.distance;
    }else{
        self.distanceLabel.text = [NSString stringWithFormat:@"%@km",villageModel.distance];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
