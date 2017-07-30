//
//  QHDateSelectCollectionViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/2/14.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPDateSelectCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *selectImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *remainingLabel;

@end
