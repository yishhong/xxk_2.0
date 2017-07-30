//
//  VPDetailStatusCell.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPDetailStatusCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *selectImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@end
