//
//  VPPhoneNumberTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPPhoneNumberTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UILabel *lineLbael;
@property (strong, nonatomic) IBOutlet UIImageView *jupmImageView;

@end
