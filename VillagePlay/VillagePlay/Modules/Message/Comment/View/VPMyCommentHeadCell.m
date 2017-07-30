//
//  VPMyCommentHeadCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMyCommentHeadCell.h"
#import <Masonry.h>
#import "XXCellModel.h"
#import "VPMyCommendModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIImageView+VPWebImage.h"
@implementation VPMyCommentHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.photoImage.layer.cornerRadius = 20;
    self.photoImage.layer.masksToBounds = YES;
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
//        make.top.mas_equalTo(self.mas_top).offset(18);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
    }];
    
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.photoImage.mas_height).multipliedBy(0.5);
        make.top.mas_equalTo(self.photoImage.mas_top).offset(0);
        make.left.mas_equalTo(self.photoImage.mas_right).offset(10);
        make.bottom.mas_equalTo(self.lb_date.mas_top).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(15);
    }];
    
    [self.lb_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.lb_name.mas_height).offset(0);
        make.width.mas_equalTo(self.lb_name.mas_width).offset(0);
        make.top.mas_equalTo(self.lb_name.mas_bottom).offset(0);
        make.left.mas_equalTo(self.lb_name.mas_left).offset(0);
        make.bottom.mas_equalTo(self.photoImage.mas_bottom).offset(0);
    }];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel * cellModel = entity;
    VPMyCommendModel *myCommendModel = cellModel.dataSource;
    [self.photoImage xx_setImageWithURLStr:myCommendModel.photoUrl placeholder:[UIImage imageNamed:@"vp_comment_headPhoto"]];
    self.lb_name.text = myCommendModel.nickname;
    self.lb_date.text = myCommendModel.createDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
