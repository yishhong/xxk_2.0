//
//  VPCollectionCommentImageCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCollectionCommentImageCell.h"
#import "UICollectionViewCell+DataSource.h"

@implementation VPCollectionCommentImageCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.pictureImage.contentMode = UIViewContentModeScaleAspectFill;
    self.pictureImage.layer.masksToBounds = YES;
}

- (void)xx_configCellWithEntity:(id)entity{
    NSDictionary *imageDict = entity;
    self.pictureImage.image = imageDict[@"image"];
    
}

@end
