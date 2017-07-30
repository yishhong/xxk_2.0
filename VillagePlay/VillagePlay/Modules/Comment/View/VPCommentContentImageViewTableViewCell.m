//
//  VPCommentContentImageViewTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentContentImageViewTableViewCell.h"
#import "VPCommentaryModel.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

@implementation VPCommentContentImageViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPCommentaryModel * commentaryModel =cellModel.dataSource;
    [self.commentCollectionView commentArray:commentaryModel.imgs];
}


@end
