//
//  QHDateSelectCollectionViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/2/14.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "VPDateSelectCollectionViewCell.h"
#import "UIColor+HUE.h"

@implementation VPDateSelectCollectionViewCell

- (void)awakeFromNib {
 
    [super awakeFromNib];
    self.selectImageView.userInteractionEnabled=YES;
//    self.dateLabel.textColor =[UIColor VPContentColor];
//    self.remainingLabel.textColor =[UIColor VPContentColor];
}

@end
