//
//  VPDestinationVillageView.m
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationVillageView.h"

#import <Masonry.h>
#import "UIColor+HUE.h"
#import "UIImageView+VPWebImage.h"
#import "VPLocationManager.h"
@interface VPDestinationVillageView ()

@end

@implementation VPDestinationVillageView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.picture = [[UIImageView alloc] init];
    self.picture.layer.masksToBounds = YES;
    self.picture.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.picture];
//    [self.picture setImage:[UIImage imageNamed:@"test.jpg"]];
    self.picture.layer.masksToBounds = YES;
    
    self.lb_title = [[UILabel alloc] init];
    [self addSubview:self.lb_title];
    self.lb_title.font = [UIFont systemFontOfSize:14];
    self.lb_title.numberOfLines = 2;
    self.lb_title.text = @"";

    self.lb_distance = [[UILabel alloc] init];
    [self addSubview:self.lb_distance];
    self.lb_distance.font = [UIFont systemFontOfSize:12];
    self.lb_distance.numberOfLines = 2;
    self.lb_distance.text = @"";
    self.lb_distance.textColor = [UIColor navigationTintColor];
    //布局View
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(114);
        make.top.mas_equalTo(self.mas_top).mas_offset(0);
        make.leading.mas_equalTo(self.mas_leading).mas_offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(0);
        make.bottom.mas_equalTo(self.lb_title.mas_top).mas_offset(0);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.picture.mas_bottom).mas_offset(0);
        make.leading.mas_equalTo(self.mas_leading).mas_offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(0);
        make.bottom.mas_equalTo(self.lb_distance.mas_top).mas_offset(0);
    }];
    
    [self.lb_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).mas_offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        make.top.mas_equalTo(self.lb_title.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(21);
    }];
}

- (void)configData:(VPVillageModel *)villageModel{
    [self.picture xx_setImageWithURLStr:villageModel.image placeholder:[UIImage imageNamed:@""]];
    self.lb_title.text = villageModel.name;
    self.lb_distance.text = [NSString stringWithFormat:@"相距%@km",[villageModel distance]];
//    self.lb_distance.text = [NSString stringWithFormat:@"相距%@KM",villageModel.distance];
}


@end
