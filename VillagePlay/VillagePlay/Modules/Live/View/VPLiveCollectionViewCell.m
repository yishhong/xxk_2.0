//
//  VPLiveCollectionViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveCollectionViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPLiveInfoModel.h"
#import "UIImageView+VPWebImage.h"
#import "NSString+NumberRound.h"

@implementation VPLiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =[UIColor controllerBackgroundColor];
    self.nameLabel.textColor =[UIColor VPContentColor];
    [self.broadcastButton setTitleColor:[UIColor navigationTintColor] forState:UIControlStateNormal];
    self.lookNumber.textColor =[UIColor VPDetailColor];

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPLiveInfoModel *liveInfoModel =cellModel.dataSource;
    [self.liveImageView xx_setImageWithURLStr:liveInfoModel.photoUrl placeholder:[UIImage imageNamed:@"vp_live_Image"]];
    self.nameLabel.text =liveInfoModel.title;
    
    self.lookNumber.text =[NSString stringWithFormat:@"%@次观看",[[@(liveInfoModel.viewNum) stringValue] numericalConversion]];

    NSDictionary * cellInfo =[liveInfoModel liveStateForInfo];
    [self.broadcastButton setTitle:cellInfo[@"title"] forState:UIControlStateNormal];
    [self.broadcastButton setTitleColor:cellInfo[@"color"] forState:UIControlStateNormal];
    [self.broadcastButton setImage:[UIImage imageNamed:cellInfo[@"image"]] forState:UIControlStateNormal];
}

@end
