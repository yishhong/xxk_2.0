//
//  VPAddressTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VPAddressTableViewCell;
@protocol VPAddressTableViewCellDelegate <NSObject>

-(void)addressTableViewCell:(VPAddressTableViewCell *)addressTableViewCell moreFacilities:(id)moreFacilities;

@end

@interface VPAddressTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
