//
//  VPUserInfoPhotoCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserInfoPhotoCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "UIImageView+VPWebImage.h"
#import "VPUserInfoModel.h"

@interface VPUserInfoPhotoCell ()
@property (nonatomic, strong) VPUserInfoModel *userInfoModel;
@end

@implementation VPUserInfoPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.photoImage.layer.cornerRadius = 54/2.0;
    self.photoImage.layer.masksToBounds = YES;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *info= cellModel.dataSource;
    self.lb_title.text = info[@"title"];
    self.userInfoModel = info[@"value"];
    if([self.userInfoModel.smallHeadPhoto isKindOfClass:[UIImage class]]){
        self.photoImage.image = self.userInfoModel.smallHeadPhoto;
    }else{
        [self.photoImage xx_setImageWithURLStr:self.userInfoModel.smallHeadPhoto placeholder:[UIImage imageNamed:info[@"placeholder"]]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
