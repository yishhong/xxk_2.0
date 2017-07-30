//
//  VPLiveCollectionViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPLiveCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *liveImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lookNumber;
@property (strong, nonatomic) IBOutlet UIButton *broadcastButton;
@end
