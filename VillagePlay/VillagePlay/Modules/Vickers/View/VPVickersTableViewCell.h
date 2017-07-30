//
//  VPVickersTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPVickersTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *vickersImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *browsedLabel;
@property (strong, nonatomic) IBOutlet UIView *belowView;

@end
