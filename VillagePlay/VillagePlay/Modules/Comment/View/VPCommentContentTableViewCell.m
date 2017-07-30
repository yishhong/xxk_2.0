//
//  VPCommentContentTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentContentTableViewCell.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "VPCommentaryModel.h"
#import "XXCellModel.h"

@implementation VPCommentContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.textColor =[UIColor VPTitleColor];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    NSDictionary * info =cellModel.dataSource;
    VPCommentaryModel *commentModel = info[@"commentModel"];
    self.contentLabel.text =commentModel.content;
//    if ([info[@"isLineHide"] isEqualToString:@""]) {
//        
//        self.lineView.hidden =YES;
//        
//    }else{
//    
//        self.lineView.hidden =NO;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
