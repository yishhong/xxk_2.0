//
//  TravelWritRefundReasonTableViewCell.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TravelWritRefundReasonTableViewCellDetegate <NSObject>

- (void)refundReasonString:(NSString *)refundReasonString;

@end

@interface TravelWritRefundReasonTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textFieldName;

@property (strong ,nonatomic) id<TravelWritRefundReasonTableViewCellDetegate>detegate;

@end
