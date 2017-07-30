//
//  VPAddDeleteTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPAddDeleteTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) IBOutlet UILabel *addressNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyNumberLabel;
@property (strong, nonatomic) IBOutlet UIView *numberView;

@end
