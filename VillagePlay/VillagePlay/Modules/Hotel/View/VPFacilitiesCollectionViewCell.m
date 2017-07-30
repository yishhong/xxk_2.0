//
//  VPFacilitiesCollectionViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPFacilitiesCollectionViewCell.h"
#import "UIColor+HUE.h"

@implementation VPFacilitiesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPTitleColor];
}

@end
