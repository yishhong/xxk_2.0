//
//  HotelOrderGoodsTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelOrderGoodsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *hotelOrderImage;
@property (strong, nonatomic) IBOutlet UILabel *checkTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *outTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@end
