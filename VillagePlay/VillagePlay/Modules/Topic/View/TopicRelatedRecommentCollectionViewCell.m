//
//  TopicRelatedRecommentCollectionViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TopicRelatedRecommentCollectionViewCell.h"
#import "UIColor+HUE.h"

@implementation TopicRelatedRecommentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor =[UIColor VPContentColor];
    self.priceLabel.textColor =[UIColor VPRedColor];
}

@end
